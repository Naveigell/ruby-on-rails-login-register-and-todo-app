class Home::HomeController < ApplicationController
    def home
        @todos = Todo::TodoModel.all

        render 'home/home', layout: false
    end
end
