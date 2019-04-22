# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  def new
    @can_signup = Config.can_signup == "1"
    super
  end
end
