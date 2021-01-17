class User::UserController < ApplicationController
    protect_from_forgery

    def login_page
        render 'user/login', :layout => false
    end

    def register
        username = params[:username]
        email = params[:email]
        password = params[:password]

        validation = RegisterValidator.new(username, email, password)
        if validation.valid?
            hashed_password = BCrypt::Password.create password

            begin
                user = User::UserModel.new :username => username, :email => email, :password => hashed_password
                user.save

                if user.persisted?
                    session[:id] = user.id
                    redirect_back fallback_location: root_path
                end
            rescue => e
                if e.message.include?("Duplicate entry")
                    redirect_to "/login", flash: {register_error: ["Duplicate username or email"]}
                end
            end
        else
            messages = []
            validation.errors.each do |attr, msg|
                messages.push msg
            end

            redirect_to "/login", flash: {register_error: messages}
        end
    end

    def logout
        session.delete :id
        redirect_to "/"
    end

    def login

        email = request.POST["email"]
        password = request.POST["password"]

        validation = LoginValidator.new(email, password)

        if validation.valid?

            user = User::UserModel.select("id, email, password").where(email: email).first
            if user == nil
                redirect_to "/login", flash: {login_error: ["User not found"]}
            elsif BCrypt::Password.new(user["password"]) == password
                session[:id] = user["id"]
                redirect_to "/"
            else
                redirect_to "/login", flash: {login_error: ["Password wrong"]}
            end
        else
            messages = []
            validation.errors.each do |attr, msg|
                messages.push msg
            end

            redirect_to "/login", flash: {login_error: messages}
        end
    end

    before_action :set_cache_headers

    private

    def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
    end
end
