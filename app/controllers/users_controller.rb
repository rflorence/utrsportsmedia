class UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token[0,20]
    @user.save
    redirect_to '/users'
  end

  private

    def user_params
      params.require(:user).permit([:email, :role])
    end
end
