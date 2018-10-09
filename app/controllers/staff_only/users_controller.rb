class StaffOnly::UsersController < ApplicationController
  include RequireStaffRoleConcern
  def index
    @users = User.all
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
