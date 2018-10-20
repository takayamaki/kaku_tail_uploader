Fabricator(:uploaded_file) do
  user
  file_name { Faker::File.file_name }
  comment   { Faker::Lorem.paragraph[0..190] }
  file_data { '{}' }
end