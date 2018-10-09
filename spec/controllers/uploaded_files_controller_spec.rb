require 'rails_helper'

describe UploadedFilesController do
  describe "GET #index" do
    subject {get :index}

    let(:user) {Fablicate(:user, role: 1)}
    let(:staff) {Fablicate(:user, role: 2)}
    let(:uploaded_file_from_user)  {Fablicate(:file, user: user)}
    let(:uploaded_file_from_admin) {Fablicate(:file, user: staff)}

    context "when current_user is not staff" do
      before {sign_in(user)}
      it "only seen uploaded files from himself"
    end

    context "when current_user is staff" do
      before {sign_in(staff)}
      it "only seen uploaded files from all users"
    end
  end
end