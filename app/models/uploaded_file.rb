# == Schema Information
#
# Table name: uploaded_files
#
#  id                        :bigint(8)        not null, primary key
#  comment                   :string           default(""), not null
#  file_data                 :text             not null
#  file_name                 :string           not null
#  start_of_15sec_frame_part :integer
#  start_of_15sec_sec_part   :integer          not null
#  start_of_30sec_frame_part :integer
#  start_of_30sec_sec_part   :integer          not null
#  start_of_60sec_frame_part :integer
#  start_of_60sec_sec_part   :integer          not null
#  thumbnail_frame_part      :integer
#  thumbnail_sec_part        :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_id                   :bigint(8)
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
  validates :file_name, :file_data, presence: true
  validates :thumbnail_sec_part, :thumbnail_frame_part,
            :start_of_15sec_sec_part, :start_of_15sec_frame_part,
            :start_of_30sec_sec_part, :start_of_30sec_frame_part,
            :start_of_60sec_sec_part, :start_of_60sec_frame_part,
            numericality: { only_integer: true }
  validates_with PreviewPointValidator

  belongs_to :user
  scope :by_upload_user_id, ->(user_id) {where(user_id: user_id)}
  paginates_per 20

  after_save :export_to_spread_sheet
  after_destroy :erase_from_spread_sheet

  def file_size_by_megabytes
    format("%.2f", file.size.to_f / 1024 ** 2)
  end

  def thumbnail_by_frame
    thumbnail_sec_part*30 + thumbnail_frame_part
  end
  def start_of_15sec_by_frame
    start_of_15sec_sec_part*30 + start_of_15sec_frame_part
  end
  def start_of_30sec_by_frame
    start_of_30sec_sec_part*30 + start_of_30sec_frame_part
  end
  def start_of_60sec_by_frame
    start_of_60sec_sec_part*30 + start_of_60sec_frame_part
  end

  private
  def export_to_spread_sheet
    SpreadSheetExportor.instance.export_uploaded_file_info(self)
  end

  def erase_from_spread_sheet
    SpreadSheetExportor.instance.erase_uploaded_file_info(self)
  end
end
