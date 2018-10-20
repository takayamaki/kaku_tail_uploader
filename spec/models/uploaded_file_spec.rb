require 'rails_helper'

describe UploadedFile, type: :model do
  let(:user) {Fabricate(:user)}

  it "is valid with a file_name" do
    uploaded_file = UploadedFile.create(file_name: "test.mp4", user: user, file_data: '{}')
    expect(uploaded_file).to be_valid
  end

  it "is invalid without file_name" do
    uploaded_file = UploadedFile.create(file_name: nil, user: user, file_data: '{}')
    expect(uploaded_file).to_not be_valid
  end

  xit "is invalid without file_data" do
    uploaded_file = UploadedFile.create(file_name: "test.mp4", user: user)
    expect(uploaded_file).to_not be_valid
  end

  it "is invalid without user" do
    uploaded_file = UploadedFile.create(file_name: "test.mp4", file_data: '{}')
    expect(uploaded_file).to_not be_valid
  end

  it "is valid with a file_name and comment" do
    uploaded_file = UploadedFile.create(file_name: "test.mp4", comment: "There is a comment.", user: user, file_data: '{}')
    expect(uploaded_file).to be_valid
  end
end