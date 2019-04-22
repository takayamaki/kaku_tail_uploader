# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_create_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :check_able_to_registration, only: [:new, :create]

  protected
  def configure_account_create_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  def check_able_to_registration
    forbidden if Config.can_signup == "0"
  end
end
