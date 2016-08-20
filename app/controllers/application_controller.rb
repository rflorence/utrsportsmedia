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
          if (request.env["HTTP_REFERER"] != nil)
            flash[:alert] = message
            redirect_to :back
          else
            redirect_to "#{Rails.root}/public/404"
          end
        }
        format.json {
          render json: { authorization: [message] }, status: :forbidden
        }
      end
    end
end
