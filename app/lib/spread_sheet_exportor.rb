require "google_drive"
require 'singleton'

class SpreadSheetExportor
  include Singleton
  include Rails.application.routes.url_helpers

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

  def update_username(user)
    sheet = get_or_create_worksheet('提出作品情報')
    sheet[user.id+1, 1] = user.id
    sheet[user.id+1, 2] = user.name
    sheet.save
  end

  def export_uploaded_file_info(file)
    sheet = get_or_create_worksheet('提出作品情報')
    sheet.update_cells(file.user_id+1, 1, [[
      file.user_id,
      file.user.name,
      I18n.l(file.created_at),
      file.file_name,
      file.thumbnail_sec_part,
      file.thumbnail_frame_part,
      file.start_of_15sec_sec_part,
      file.start_of_15sec_frame_part,
      file.start_of_30sec_sec_part,
      file.start_of_30sec_frame_part,
      file.start_of_60sec_sec_part,
      file.start_of_60sec_frame_part,
      "http://#{ENV.fetch('DOMAIN_NAME'){'localhost:3000'}}#{uploaded_file_path(file)}",
    ]])
    sheet.save
  end

  def erase_uploaded_file_info(user_id)
    sheet = get_or_create_worksheet('提出作品情報')
    sheet.update_cells(user_id+1, 3, [[
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ]])
    sheet.save
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
    return GoogleDrive::Session.new_dummy if Rails.env.test?
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
