class ApplicationController < ActionController::Base
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized(exception)
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to request.referer
    end
end
