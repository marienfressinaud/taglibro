require 'rails_helper'

RSpec.describe "User session management" do

  describe "registration" do
    before do
      payload = {
        user: {
          email: 'john@doe.com',
          password: 'secret',
          password_confirmation: 'secret',
        }
      }

      post '/users', params: payload
    end

    it "shows a registration form" do
      get '/register'

      assert_select 'form' do
        assert_select 'input[name=?]', 'user[email]'
        assert_select 'input[name=?]', 'user[password]'
        assert_select 'input[name=?]', 'user[password_confirmation]'
      end
    end

    it "creates a new user when posting on /users" do
      expect(User.where(email: 'john@doe.com').count).to eq(1)
    end

    it "redirects to the home page" do
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include("Un mail de confirmation vous a été envoyé à l’adresse john@doe.com")
    end
  end

  describe "activation" do
    before do
      @user = create(:user)

      get "/users/#{ @user.activation_token }/activate"
    end

    it "activates the user " do
      expect(@user.reload.activation_state).to eq('active')
    end

    it "redirects to the login page" do
      expect(response).to redirect_to('/login')
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "login and logout" do
    it "shows a login form" do
      get '/login'

      assert_select 'form' do
        assert_select 'input[name=?]', 'email'
        assert_select 'input[name=?]', 'password'
      end
    end

    it "redirects to the diary when log in is successful" do
      user = create(:user_activated, password: 'secret')
      payload = {
        email: user.email,
        password: 'secret',
      }
      post '/user_sessions', params: payload

      expect(response).to redirect_to('/diary')
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user.email)
    end

    it "redirects to the home page when log out is successful" do
      login

      post '/logout'

      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Vous êtes désormais déconnecté.')
    end
  end

  describe "redirections for logged users" do
    before do
      login
    end

    it "redirects to diary if he tries to access home page" do
      get '/'
      expect(response).to redirect_to('/diary')
    end

    it "redirects to diary if he tries to access registration page" do
      get '/register'
      expect(response).to redirect_to('/diary')
    end

    it "redirects to diary if he tries to access login page" do
      get '/login'
      expect(response).to redirect_to('/diary')
    end

    it "redirects to diary if he tries to access reset password page" do
      get '/password_resets/new'
      expect(response).to redirect_to('/diary')
    end
  end

end
