class AuthenticationMiddleware

    REDIRECT_IF_NOT_AUTHENTICATE = %w[/todo]
    REDIRECT_IF_AUTHENTICATE = %w[/login]

    def initialize(app)
        @app = app
    end

    def call(env)
        status, headers, response = @app.call(env)

        request = Rack::Request.new(env)

        if (has_path(REDIRECT_IF_NOT_AUTHENTICATE, request.path) || request.path == "/") && request.session[:id] == nil
            return [302, {'Location' => "/login"}, []]
        elsif (has_path(REDIRECT_IF_AUTHENTICATE, request.path)) && request.session[:id] != nil
            return [302, {'Location' => "/"}, []]
        end
        [status, headers, response]

        # html = ActionView::Base.new.render(file: 'public/403.html')
        # [503, {'Content-Type' => 'text/html'}, [html]]
    end

    def has_path(array = [], path)
        array.each do |item|
            if item == "/"; next; end

            return true if path.include?(item)
        end

        false
    end
end
