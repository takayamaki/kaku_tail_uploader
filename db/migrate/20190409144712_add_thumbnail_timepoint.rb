class AddThumbnailTimepoint < ActiveRecord::Migration[5.2]
  def change
    # add_column :uploaded_files, :thumbnail, :float, null: false
    add_column :uploaded_files, :thumbnail, :float
    add_column :uploaded_files, :thumbnail_by_frame, :integer

    UploadedFile.all.each do |f|
      f.thumbnail = f.start_of_15sec
      f.save!
    end

    change_column :uploaded_files, :thumbnail, :float, null: false
  end
end
