class SessionsController < ApplicationController
  def signup
    user = User.new(user_params)

    if user.save
      token = encode_user_data({ user_id: user.id })

      render json: { token: token }, status: :ok
    else
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token = encode_user_data({user_id: user.id})

      render json: { token: token }, status: :ok
    else 
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
