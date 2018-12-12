class StaffOnly::RolesController < ApplicationController
  include RequireStaffRoleConcern
  include ChangeRoleConcern
  before_action :set_target_user

  def upgrade
    @user.upgrade_role if able_to_upgrade_role?
    redirect_to staff_only_user_path(@user.id)
  end

  def downgrade
    @user.downgrade_role if able_to_downgrade_role?
    redirect_to staff_only_user_path(@user.id)
  end

  private
  def target_user_params
    params.permit(:user_id)
  end

  def set_target_user
    @user = User.find(target_user_params[:user_id]) || raise(ActiveRecord::RecordNotFound)
  end
end
