class ChangeTimepointValidation < ActiveRecord::Migration[5.2]
  def change
    change_column :uploaded_files, :thumbnail, :integer, null: false
    change_column :uploaded_files, :start_of_15sec, :integer, null: false
    change_column :uploaded_files, :start_of_30sec, :integer, null: false
    change_column :uploaded_files, :start_of_60sec, :integer, null: false

    rename_column :uploaded_files, :thumbnail, :thumbnail_sec_part
    rename_column :uploaded_files, :start_of_15sec, :start_of_15sec_sec_part
    rename_column :uploaded_files, :start_of_30sec, :start_of_30sec_sec_part
    rename_column :uploaded_files, :start_of_60sec, :start_of_60sec_sec_part

    add_column :uploaded_files, :thumbnail_frame_part, :integer
    add_column :uploaded_files, :start_of_15sec_frame_part, :integer
    add_column :uploaded_files, :start_of_30sec_frame_part, :integer
    add_column :uploaded_files, :start_of_60sec_frame_part, :integer
  end
end
