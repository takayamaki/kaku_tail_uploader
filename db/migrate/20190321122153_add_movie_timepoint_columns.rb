class AddMovieTimepointColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :uploaded_files, :start_of_15sec, :float, null: false
    add_column :uploaded_files, :start_of_30sec, :float, null: false
    add_column :uploaded_files, :start_of_60sec, :float, null: false

    add_column :uploaded_files, :start_of_15sec_by_frame, :integer
    add_column :uploaded_files, :start_of_30sec_by_frame, :integer 
    add_column :uploaded_files, :start_of_60sec_by_frame, :integer
  end
end
