require "google_drive"
require 'singleton'

class SpreadSheetExportor
  include Singleton

  def initialize
    @credentials = Google::Auth::UserRefreshCredentials.new(
      client_id:     Config.google_drive_client_id,
      client_secret: Config.google_drive_client_secret,
      refresh_token: Config.google_drive_refresh_token,
      scope:         'https://www.googleapis.com/auth/drive.file',
      redirect_uri:  'urn:ietf:wg:oauth:2.0:oob',
    )
    @defaultSpreadSheetName = Config.defaultSpreadSheetName
  end

  def get_or_create_worksheet(workSheetName, spreadSheetName = @defaultSpreadSheetName.to_s)
    spreadsheet = get_or_create_spreadsheet(spreadSheetName)
    @workSheets ||= {}
    @workSheets["#{spreadSheetName}/#{workSheetName}"] ||=
      spreadsheet.worksheet_by_title(workSheetName) ||
      spreadsheet.add_worksheet(workSheetName)
  end

  private
  def create_session
    GoogleDrive::Session.new_dummy if Rails.env.test?
    @credentials.fetch_access_token!
    GoogleDrive::Session.from_credentials(@credentials)
  end

  def get_or_create_session
    @session ||= create_session
  end

  def get_or_create_spreadsheet(spreadSheetName)
    session = get_or_create_session
    @spreadSheets ||= {}
    @spreadSheets[spreadSheetName] ||=
      session.spreadsheet_by_title(spreadSheetName.to_s) ||
      session.create_spreadsheet(spreadSheetName.to_s)
  end
end
