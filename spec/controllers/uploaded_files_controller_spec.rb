require 'rails_helper'

describe UploadedFilesController, type: :controller do
  describe "GET #index" do
    subject {get :index}

    let(:unothorized_user) {Fabricate(:user, role: 0)}

    let(:creator) {Fabricate(:user, role: 1)}
    let(:uploaded_file_from_creator)  {Fabricate(:uploaded_file, user: creator)}

    let(:other_creator) {Fabricate(:user, role: 1)}
    let(:uploaded_file_from_other_creator)  {Fabricate(:uploaded_file, user: other_creator)}

    let(:staff) {Fabricate(:user, role: 2)}
    let(:uploaded_file_from_staff) {Fabricate(:uploaded_file, user: staff)}

    let(:admin) {Fabricate(:user, role: 4)}
    let(:uploaded_file_from_admin) {Fabricate(:uploaded_file, user: admin)}

    context "unothorized users can not see any files with 403" do
      before {sign_in(unothorized_user)}
      it do 
        subject
        expect(response).to redirect_to('/401')
      end
    end

    context "creators only can see uploaded files from themself" do
      before {sign_in(creator)}
      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_creator).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_other_creator).to be false
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_staff).to be false
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_admin).to be false
      end
    end

    context "staff can see uploaded files from all users" do
      before {sign_in(staff)}
      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_creator).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_other_creator).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_staff).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_admin).to be true
      end
    end


    context "admin can see uploaded files from all users" do
      before {sign_in(admin)}
      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_creator).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_other_creator).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_staff).to be true
      end

      it do
        subject
        expect(assigns(:uploaded_files).include? uploaded_file_from_admin).to be true
      end
    end
  end
end
