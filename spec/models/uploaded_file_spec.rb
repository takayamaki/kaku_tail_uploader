require 'rails_helper'

describe UploadedFile, type: :model do
  let(:user) {Fabricate(:user)}

  context 'is valid' do
    it "with a file_name" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5)
      expect(uploaded_file).to be_valid
    end

    it "with a file_name and comment" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", comment: "There is a comment.", user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5)
      expect(uploaded_file).to be_valid
    end

    it "with start point by frame" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5,
        start_of_15sec_by_frame: 346, start_of_30sec_by_frame: 315, start_of_60sec_by_frame: 283)
      expect(uploaded_file).to be_valid
    end

    it "when all start point are 0.0" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 0.0, start_of_30sec: 0.0, start_of_60sec: 0.0)
      expect(uploaded_file).to be_valid
    end

    it "when each start point are 45, 30, 0" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 45.0, start_of_30sec: 30.0, start_of_60sec: 0.0)
      expect(uploaded_file).to be_valid
    end

    it "when each start point are 195, 180, 150" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 195.0, start_of_30sec: 180.0, start_of_60sec: 150.0)
      expect(uploaded_file).to be_valid
    end
  end

  context 'is invalid' do
    it "without file_name" do
      uploaded_file = UploadedFile.create(
        file_name: nil, user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5)
      expect(uploaded_file).to_not be_valid
    end
  
    it "without file_data" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", user: user,
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5)
      expect(uploaded_file).to_not be_valid
    end
  
    it "without user" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4", file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5)
      expect(uploaded_file).to_not be_valid
    end

    it "when start point by frame is not integer" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5,
        start_of_15sec_by_frame: 34.6, start_of_30sec_by_frame: 31.5, start_of_60sec_by_frame: 28.3)
      expect(uploaded_file).to_not be_valid
    end

    it "with start point by frame but without by sec" do
      uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec_by_frame: 150, start_of_30sec_by_frame: 150, start_of_60sec_by_frame: 150)
      expect(uploaded_file).to_not be_valid
    end

    context "when 30sec are" do
      it "after 15sec" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 111.1, start_of_60sec: 76.5)
        expect(uploaded_file).to_not be_valid
      end

      it "too much before 15sec" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 34.6, start_of_60sec: 28.3)
        expect(uploaded_file).to_not be_valid
      end
    end

    context "when 60sec are" do
      it "after 30sec" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 111.1)
        expect(uploaded_file).to_not be_valid
      end

      it "too much before 30sec" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 31.5)
        expect(uploaded_file).to_not be_valid
      end
    end

    context "when 30sec by frame are" do
      it "after 15sec by frame" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5,
        start_of_15sec_by_frame: 346, start_of_30sec_by_frame: 573, start_of_60sec_by_frame: 283)
        expect(uploaded_file).to_not be_valid
      end
    end

    context "when 60sec by frame are" do
      it "after 30sec by frame" do
        uploaded_file = UploadedFile.create(
        file_name: "test.mp4",  user: user, file_data: '{}',
        start_of_15sec: 96.1, start_of_30sec: 87.6, start_of_60sec: 76.5,
        start_of_15sec_by_frame: 573, start_of_30sec_by_frame: 315, start_of_60sec_by_frame: 346)
        expect(uploaded_file).to_not be_valid
      end
    end
  end
end