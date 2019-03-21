Fabricator(:uploaded_file) do
  user
  file_name { Faker::File.file_name }
  comment   { Faker::Lorem.paragraph[0..190] }
  file_data { '{}' }
  start_of_15sec { 0 }
  start_of_30sec { 0 }
  start_of_60sec { 0 }
end