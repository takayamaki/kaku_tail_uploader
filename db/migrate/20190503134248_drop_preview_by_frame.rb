class DropPreviewByFrame < ActiveRecord::Migration[5.2]
  def change
    remove_column :uploaded_files, :thumbnail_by_frame, :integer
    remove_column :uploaded_files, :start_of_15sec_by_frame, :integer
    remove_column :uploaded_files, :start_of_30sec_by_frame, :integer 
    remove_column :uploaded_files, :start_of_60sec_by_frame, :integer
  end
end
