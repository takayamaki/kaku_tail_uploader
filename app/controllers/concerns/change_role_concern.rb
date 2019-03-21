module ChangeRoleConcern
  extend ActiveSupport::Concern

  def able_to_upgrade_role?
    return false if @user.admin_role? || @user == current_user
    
    @user.role_before_type_cast < current_user.role_before_type_cast - 1
  end

  def able_to_downgrade_role?
    return false if @user == current_user

    @user.role_before_type_cast < current_user.role_before_type_cast
  end
end
