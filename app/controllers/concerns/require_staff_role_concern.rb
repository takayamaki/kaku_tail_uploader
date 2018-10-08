module RequireStaffRoleConcern
  extend ActiveSupport::Concern

  included do
    include RequireAuthenticateConcern
    before_action :require_staff
  end
end
