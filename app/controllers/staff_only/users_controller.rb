class StaffOnly::UsersController < ApplicationController
  include RequireStaffRoleConcern
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @able_to_upgrade_role = able_to_upgrade_role?
    @able_to_downgrade_role = able_to_downgrade_role?
  end

  private
  def able_to_upgrade_role?
    return false if @user.admin_role?
    return true if current_user.admin_role?
    
    @user.role_before_type_cast < current_user.role_before_type_cast - 1
  end

  def able_to_downgrade_role?
    return false if @user.unauthorized_role?
    return true if current_user.admin_role?

    @user.role_before_type_cast < current_user.role_before_type_cast
  end
end
