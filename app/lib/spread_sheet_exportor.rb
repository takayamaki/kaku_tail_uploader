require "google_drive"
require 'singleton'

class SpreadSheetExportor
  include Singleton
  attr_writer :credentials

  def get_or_create_session
    @session ||= create_session
  end

  private
  def create_session
    @credentials.fetch_access_token!
    GoogleDrive::Session.from_credentials(@credentials)
  end
end
