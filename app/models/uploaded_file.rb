# == Schema Information
#
# Table name: uploaded_files
#
#  id         :bigint(8)        not null, primary key
#  comment    :string           default(""), not null
#  file_data  :text             not null
#  file_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_uploaded_files_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UploadedFile < ApplicationRecord
  include FileUploader[:file]
  validates :file_name, presence: true
  belongs_to :user
  scope :by_upload_user_id, ->(user_id) {where(user_id: user_id)}
  paginates_per 20

  def file_size_by_megabytes
    format("%.2f", file.size.to_f / 1024 ** 2)
  end
end
