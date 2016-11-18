require 'rails_helper'

RSpec.describe "Exploration" do

  before do
    Timecop.freeze(Time.local(1992))
    @user = login
  end

  after do
    Timecop.return
  end

  describe "explore" do
    it "shows all the thoughts from the last 24 hours" do
      create(:thought, content: 'An old thought', created_at: 25.hours.ago)
      create(:thought, content: 'My thought', user: @user)
      create(:thought, content: 'An other thought')

      get '/explore'

      expect(response.body).to include('My thought')
      expect(response.body).to include('An other thought')
      expect(response.body).to_not include('An old thought')
    end
  end

end
