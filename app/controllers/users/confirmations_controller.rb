# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def new
    @can_signup = Config.can_signup == "1"
    super
  end
end
