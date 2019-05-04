require 'rails_helper'

describe UploadedFile, type: :model do
  let(:user) {Fabricate(:user)}

  context 'is valid' do
    it "with a file_name" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it "with a file_name and comment" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", comment: "There is a comment.", user: user, file_data: '{}',
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it "when all start point are 0" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it "when each start point are 195, 180, 150" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        thumbnail_sec_part: 150, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 135, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 120, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 90, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end
  end

  context 'is invalid' do
    it "without file_name" do
      uploaded_file = UploadedFile.create(
        file_name: nil, user: user, file_data: '{}',
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  
    it "without file_data" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user,
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  
    it "without user" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", file_data: '{}',
        thumbnail_sec_part: 0, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 0, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 0, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 0, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  end

  context "frame part of shorter section are greater than longer one" do
    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 59, thumbnail_frame_part: 1,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        thumbnail_sec_part: 60, thumbnail_frame_part: 1,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 61, thumbnail_frame_part: 1,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 75, thumbnail_frame_part: 1,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 76, thumbnail_frame_part: 1,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  end

  context "frame part of shorter section are less than longer one" do
    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 59, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:1,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        thumbnail_sec_part: 60, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:1,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 61, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:1,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 75, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:1,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 76, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:1,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  end

  context "frame part of shorter section are equal with longer one" do
    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 59, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        thumbnail_sec_part: 60, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 61, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 75, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to be_valid
    end

    it do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        thumbnail_sec_part: 76, thumbnail_frame_part: 0,
        start_of_15sec_sec_part: 60, start_of_15sec_frame_part:0,
        start_of_30sec_sec_part: 60, start_of_30sec_frame_part:0,
        start_of_60sec_sec_part: 60, start_of_60sec_frame_part:0)
      expect(uploaded_file).to_not be_valid
    end
  end
end