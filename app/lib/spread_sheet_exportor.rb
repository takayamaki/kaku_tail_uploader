require "google_drive"
require 'singleton'

class SpreadSheetExportor
  include Singleton
  attr_writer :credentials

  def get_or_create_worksheet(spreadSheetName, workSheetName)
    spreadsheet = get_or_create_spreadsheet(spreadSheetName)
    @workSheets ||= {}
    @workSheets["#{spreadSheetName}/#{workSheetName}"] ||=
      spreadsheet.worksheet_by_title(workSheetName) ||
      spreadsheet.add_worksheet(workSheetName)
  end

  private
  def create_session
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
