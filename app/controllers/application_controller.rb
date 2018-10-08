class ApplicationController < ActionController::Base
  private
  def require_staff
    forbidden unless current_user&.staff?
  end

  protected
  def forbidden
    head 403
  end

  def not_found
    head 404
  end
end
