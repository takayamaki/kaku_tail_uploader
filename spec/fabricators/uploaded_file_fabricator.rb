Fabricator(:uploaded_file) do
  user
  file_name { Faker::File.file_name }
  comment   { Faker::Lorem.paragraph[0..190] }
  file_data '{}'
  thumbnail_sec_part 0
  thumbnail_frame_part 0
  start_of_15sec_sec_part 0
  start_of_15sec_frame_part 0
  start_of_30sec_sec_part 0
  start_of_30sec_frame_part 0
  start_of_60sec_sec_part 0
  start_of_60sec_frame_part 0
end