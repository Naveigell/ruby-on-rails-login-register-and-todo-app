class Todo::TodoController < ApplicationController
    protect_from_forgery
    before_action :set_cache_headers

    def delete
        if session[:id].nil?
            redirect_to "/"
            return
        end

        @todo = Todo::TodoModel.where(id: params[:id]).first
        if @todo == nil
            flash[:error] = ["Todo not found"]
        else
            record = @todo.destroy
            if record.destroyed?
                flash[:success] = "Todo deleted"
            else
                flash[:error] = "Something wrong"
            end
        end
        redirect_to "/"
    end

    def update
        title = params[:title]
        description = params[:description]

        validation = TodoValidator.new(title, description)
        if validation.valid?
            updated = Todo::TodoModel.where(id: params[:id]).update(title: title, description: description)

            if updated.length > 0
                flash[:success] = "Insert todo success"
                redirect_to "/"
            else
                flash[:error] = ["Something wrong, insert failed"]
                redirect_back fallback_location: root_path
            end
        else
            errors = []
            validation.errors.each do |attr, message|
                errors.push message
            end

            flash[:error] = errors

            redirect_back fallback_location: root_path
        end
    end

    def edit
        if session[:id].nil?
            redirect_to "/"; return
        end

        @todo = Todo::TodoModel.where(id: params[:id]).first
        if @todo.nil?
            redirect_to "/"; return
        end

        render 'todo/edit', layout: false
    end

    def create
        title = request.POST["title"]
        description = request.POST["description"]

        validation = TodoValidator.new(title, description)

        if validation.valid?
            @todo = Todo::TodoModel.new :title => title, :description => description
            @saved = @todo.save

            if @todo.persisted?
                flash[:success] = "Insert todo success"
            else
                flash[:error] = ["Something wrong, insert failed"]
            end

            redirect_to "/"
        else
            errors = []
            validation.errors.each do |attr, message|
                errors.push message
            end

            flash[:error] = errors

            redirect_to "/"
        end

    end

    private
    def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
    end
end
