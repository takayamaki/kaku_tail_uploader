class StaffOnly::UsersController < ApplicationController
  include RequireStaffRoleConcern
  include ChangeRoleConcern

  def index
    @users = User.page(params[:page])
    @users = @users.role_by(params['role']) if params['role']
  end

  def show
    @user = User.find(params[:id])
    @able_to_upgrade_role = able_to_upgrade_role?
    @able_to_downgrade_role = able_to_downgrade_role?
    @upload_files_count = @user.uploaded_file.count
  end
end
