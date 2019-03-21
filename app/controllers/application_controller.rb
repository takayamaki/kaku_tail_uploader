class ApplicationController < ActionController::Base
  private
  def require_staff
    forbidden unless current_user&.staff?
  end

  protected
  def forbidden
    redirect_to '/403'
  end

  def not_found
    redirect_to '/404'
  end

  def unauthorized
    redirect_to '/401'
  end
end
