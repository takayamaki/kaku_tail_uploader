# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
    @can_signup = Config.can_signup == "1"
    super
  end
end
