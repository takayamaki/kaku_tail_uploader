class StaffOnly::ConfigsController < ApplicationController
  include RequireStaffRoleConcern
  # before_action :get_setting, only: [:edit, :update]

  def show
    @configs = Form::ConfigForm.new
  end

  def update
    configs_params.each do |key, value|
      config = Config.where(var: key).first_or_initialize(var: key)
      config.update(value: value)
    end
  end

  private
  def configs_params
    params.require(:form_config_form).permit(*Form::ConfigForm::KEYS)
  end
end
