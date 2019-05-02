# == Schema Information
#
# Table name: uploaded_files
#
#  id                        :bigint(8)        not null, primary key
#  comment                   :string           default(""), not null
#  file_data                 :text             not null
#  file_name                 :string           not null
#  start_of_15sec_by_frame   :integer
#  start_of_15sec_frame_part :integer
#  start_of_15sec_sec_part   :integer          not null
#  start_of_30sec_by_frame   :integer
#  start_of_30sec_frame_part :integer
#  start_of_30sec_sec_part   :integer          not null
#  start_of_60sec_by_frame   :integer
#  start_of_60sec_frame_part :integer
#  start_of_60sec_sec_part   :integer          not null
#  thumbnail_by_frame        :integer
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
  validates :start_of_15sec, :start_of_30sec, :start_of_60sec, numericality: true
  validates :start_of_15sec_by_frame, :start_of_30sec_by_frame, :start_of_60sec_by_frame, numericality: { allow_nil: true, only_integer: true }
  validates_each :thumbnail, :start_of_30sec, :start_of_60sec, :thumbnail_by_frame, :start_of_30sec_by_frame, :start_of_60sec_by_frame do |record, attr, value|
    case attr
    when :thumbnail
      # サムネイルは15秒区間に含まれていなければならないため、start_of_15secとthumbnailの差は15秒以内
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_thumbnail')) unless (0.0 .. 15.0).include? value.to_f - record.start_of_15sec.to_f 
    when :start_of_30sec
      # 30秒区間は15秒区間を全て含んでいなければならないため、start_of_30secとstart_of_15secの差は15秒以内
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_prev_section')) unless (0.0 .. 15.0).include? record.start_of_15sec.to_f - value.to_f
    when :start_of_60sec
      # 60秒区間は15秒区間を全て含んでいなければならないため、start_of_60secとstart_of_30secの差は30秒以内
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_prev_section')) unless (0.0 .. 30.0).include? record.start_of_30sec.to_f - value.to_f
    when :thumbnail_by_frame
      # フレーム数はfpsによって変動するので前すぎる場合は判別できないが、少なくとも15秒区間がサムネイルの指定よりも後である場合はありえない
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_thumbnail')) unless record.start_of_15sec_by_frame.to_i <= value.to_i
    when :start_of_30sec_by_frame
      # フレーム数はfpsによって変動するので前すぎる場合は判別できないが、少なくとも30秒区間が15秒区間の指定よりも後である場合はありえない
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_prev_section')) unless value.to_i <= record.start_of_15sec_by_frame.to_i
    when :start_of_60sec_by_frame
      # フレーム数はfpsによって変動するので前すぎる場合は判別できないが、少なくとも60秒区間が30秒区間の指定よりも後である場合はありえない
      record.errors.add(attr, I18n.t('uploaded_files.new.error_not_include_prev_section')) unless value.to_i <= record.start_of_30sec_by_frame.to_i
    end
  end

  belongs_to :user
  scope :by_upload_user_id, ->(user_id) {where(user_id: user_id)}
  paginates_per 20

  def file_size_by_megabytes
    format("%.2f", file.size.to_f / 1024 ** 2)
  end
end
