class CreateUploadedFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :uploaded_files do |t|
      t.string :file_name, null: false
      t.string :comment, null:false, default: ''
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
