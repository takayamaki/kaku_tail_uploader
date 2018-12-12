class StaffOnly::UsersController < ApplicationController
  include RequireStaffRoleConcern
  include ChangeRoleConcern

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @able_to_upgrade_role = able_to_upgrade_role?
    @able_to_downgrade_role = able_to_downgrade_role?
  end
end
