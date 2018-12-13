class StaffOnly::UsersController < ApplicationController
  include RequireStaffRoleConcern
  include ChangeRoleConcern

  def index
    if params['role']
      @users = User.role_by(params['role']).page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @able_to_upgrade_role = able_to_upgrade_role?
    @able_to_downgrade_role = able_to_downgrade_role?
  end
end
