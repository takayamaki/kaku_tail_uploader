module RequireAuthorizedConcern
  extend ActiveSupport::Concern

  included do
    include RequireAuthenticateConcern
    before_action :require_authorized
  end
end
