class ApplicationController < ActionController::API
  SECRET = ENV['AUTH_SECRET']
  include ::ActionController::Cookies  
  def authenticate
    jwt = cookies.signed[:jwt]
    decoded_data = decode_user_data(jwt)
    user_id = decoded_data[0]["user_id"] unless !decoded_data
    @current_user = User.find(user_id) unless !user_id


    if @current_user
      return true
    else 
      render json: { message: "invalid credentials" }, status: :unauthorized
    end
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, "HS256"
  end

  def decode_user_data(token)
    begin
      JWT.decode token, SECRET, { algorithm: "HS256" }
    rescue => exception
      puts exception 
    end
  end
end
