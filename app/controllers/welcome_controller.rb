class WelcomeController < ApplicationController

  before_action :require_not_logged
  skip_before_action :require_login

  def index
  end

end
