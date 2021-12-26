class ApplicationController < ActionController::API
  SECRET = ENV['AUTH_SECRET']
  include ::ActionController::Cookies
  def authenticate
    jwt = cookies.signed[:jwt]
    decoded_data = decode_user_data(jwt)
    user_id = decoded_data[0]['user_id'] if decoded_data
    @current_user = User.find(user_id) if user_id

    if @current_user
      true
    else
      render json: { message: 'invalid credentials' }, status: :unauthorized
    end
  end

  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  def decode_user_data(token)
    JWT.decode token, SECRET, { algorithm: 'HS256' }
  rescue StandardError => e
    puts e
  end
end
