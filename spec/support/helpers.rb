module Helpers
  def sign_in
    @user = FactoryBot.create(:user)
    token = JWT.encode({ user_id: @user.id }, ENV['AUTH_SECRET'], 'HS256')
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.signed[:jwt] = { value: token, httpOnly: true }
    cookies[:jwt] = my_cookies[:jwt]
  end
end
