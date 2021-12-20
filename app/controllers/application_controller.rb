class ApplicationController < ActionController::API
  SECRET = "abcdefg"
  helper_method :current_user
  
  def authenticate
    decoded_data = decode_user_data(request.headers["token"])
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

  private 
  def current_user
    decoded_data = decode_user_data(request.headers["token"])
    user_id = decoded_data[0]["user_id"] unless !decoded_data
    @current_user ||= User.find(user_id) unless !user_id
  end
end
