class AddFileDataColumnToUploadedFileModel < ActiveRecord::Migration[5.2]
  def change
    add_column :uploaded_files, :file_data, :text, null: false
  end
end
