class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from User::NotAuthorized, with: :user_not_authorized

  private

    def require_admin
      raise User::NotAuthorized unless current_user.is_admin?
    end

    def user_not_authorized
      message = "You don't have access to this section."

      respond_to do |format|
        format.html {
          redirect_to '/404.html'
        }
        format.json {
          render json: { authorization: [message] }, status: :forbidden
        }
      end
    end
end
