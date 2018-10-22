require "shrine"
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = {
    bucket:            ENV.fetch('AWS_BUCKET'),
    region:            ENV.fetch('AWS_REGION'){'ap-northeast-1'},
  }
else
  s3_options = {
    access_key_id:      'KAKUTAIL/DEVELOPMENT',
    secret_access_key:  'KAKUTAIL/DEVELOPMENT',
    bucket:             'kakutail-store',
    endpoint:           'http://localhost:9000',
    region:             'us-east-1',
    force_path_style:   true,
  }
end

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(**s3_options),
}
Shrine.plugin :activerecord
Shrine.plugin :presign_endpoint, presign_options: -> (request) do
  filename     = request.params["fileName"]
  extension    = File.extname(filename)
  content_type = Rack::Mime.mime_type(extension)

  {
    content_disposition: "attachment; filename=\"#{filename}\"", # download with original filename
    content_type:        content_type,                           # set correct content type
    method: :put
  }
end
