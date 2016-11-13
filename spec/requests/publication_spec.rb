require 'rails_helper'

RSpec.describe "Publication" do

  before do
    @user = login
  end

  describe "diary" do
    before do
      Timecop.freeze(Time.local(1992))
    end

    after do
      Timecop.return
    end

    it "shows a publication form" do
      get '/diary'

      assert_select 'form' do
        assert_select 'textarea[name=?]', 'thought[content]'
      end
    end

    it "hides the publisher if a thought has been published today" do
      create :thought, user: @user

      get '/diary'

      assert_select 'form', false, 'Publisher is not supposed to be displayed'
    end

    it "shows the publisher back the next day" do
      create :thought, user: @user
      Timecop.freeze 1.day.from_now

      get '/diary'

      assert_select 'form', true, 'Publisher should be displayed'
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

    it "does not publish if user try to publish twice a day" do
      payload = {
        thought: {
          content: 'The thought strikes back',
        },
      }
      post '/thoughts', params: payload

      expect(response).to redirect_to(diary_path)
      follow_redirect!
      expect(response.body).to_not include('The thought strikes back')
    end
  end

end
