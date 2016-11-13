require 'rails_helper'

RSpec.describe "Publication" do

  before do
    @user = login
  end

  describe "diary" do
    it "shows a publication form" do
      get '/diary'

      assert_select 'form' do
        assert_select 'textarea[name=?]', 'thought[content]'
      end
    end
  end

  describe "new thought" do
    before do
      Timecop.freeze(Time.local(1992))

      payload = {
        thought: {
          content: 'A new thought',
        },
      }

      post '/thoughts', params: payload
    end

    after do
      Timecop.return
    end

    it "creates a new Thought belonging to logged user" do
      expect(@user.thoughts.count).to eq(1)
    end

    it "creates a new Thought at the current date" do
      thought = @user.thoughts.first
      expect(thought.created_at).to eq(DateTime.current)
    end

    it "redirects on the diary page" do
      expect(response).to redirect_to(diary_path)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response.body).to include('A new thought')
    end
  end

end
