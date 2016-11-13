module AuthenticationForRequests

  def login(user: nil, password: 'secret')
    user = create(:user_activated, password: password) if user.nil?
    payload = {
      email: user.email,
      password: password,
    }
    post user_sessions_path, params: payload
    expect(response).to have_http_status(:found)
    user
  end

end

RSpec.configure do |config|
  config.include AuthenticationForRequests, type: :request
end
