class ErrorsController < ApplicationController
  include RequireAuthenticateConcern

  def not_found
    @message = t('shared.error.not_found')
    render status: 404
  end

  def unauthorized
    @message = t('shared.error.unauthorized')
    render status: 401
  end

  def forbidden
    @message = t('shared.error.forbidden')
    render status: 403
  end
end
