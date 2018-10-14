require "shrine"
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = {
    bucket:            ENV.fetch('AWS_BUCKET'),
    region:            ENV.fetch('AWS_REGION'){'ap-northeast-1'},
  }
else
  s3_options = {
    access_key_id:      'KAKUTAILDEVELOPMENT',
    secret_access_key:  'KAKUTAILDEVELOPMENT',
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
Shrine.plugin :presign_endpoint, presign_options: { method: :put }
