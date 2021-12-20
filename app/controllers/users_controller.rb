class UsersController < ApplicationController
  before_action :authenticate

  def show
    render json: { username: @current_user.username }, status: :ok
  end
end
