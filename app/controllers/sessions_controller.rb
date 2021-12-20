class SessionsController < ApplicationController
  def signup
    user = User.new(user_params)

    if user.save
      token = encode_user_data({ user_id: user.id })
      cookies.signed[:jwt] = {value: token, httponly: true}
      render json: { username: user.username }, status: :ok
    else
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token = encode_user_data({user_id: user.id})
      cookies.signed[:jwt] = {value: token, httponly: true}
      render json: { username: user.username }, status: :ok
    else 
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  def logout
    cookies.delete(:jwt)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
