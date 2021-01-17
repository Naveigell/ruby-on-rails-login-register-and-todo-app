class Error::ErrorController < ApplicationController

    ERROR_LIST = {
        '403' => 'Forbidden',
        '404' => 'Not Found',
    }

    def error
        @code = params[:code]
        @message = ERROR_LIST[@code]

        if @message == nil
            @code = '404'
            @message = ERROR_LIST[@code]
        end

        render "errors/error", layout: false
    end
end
