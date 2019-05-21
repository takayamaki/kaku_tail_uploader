SpreadSheetExportor.instance.credentials = Google::Auth::UserRefreshCredentials.new(
  client_id:     ENV.fetch('GOOGLE_DRIVE_CLIENT_ID'),
  client_secret: ENV.fetch('GOOGLE_DRIVE_CLIENT_SECRET'),
  refresh_token: ENV.fetch('GOOGLE_DRIVE_REFRESH_TOKEN'),
  scope:         'https://www.googleapis.com/auth/drive.file',
  redirect_uri:  'urn:ietf:wg:oauth:2.0:oob',
)
