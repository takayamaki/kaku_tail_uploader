class UploadedFilesController < ApplicationController
  include RequireAuthorizedConcern

  def index
    if current_user.staff?
      @uploaded_files = UploadedFile.all
    elsif current_user.unauthorized_role?
      forbidden
    else
      @uploaded_files = UploadedFile.uploaded_by(current_user)
    end
  end

  def new
    @uploaded_file = current_user.uploaded_file.build
    render layout: 'layouts/upload_form'
  end


  def create
    @uploaded_file = current_user.uploaded_file.create(uploaded_file_params)

    if @uploaded_file.save
      redirect_to @uploaded_file, notice: 'Uploaded file was successfully created.'
    else
      render :new
    end
  end

  def destroy
  end

  def show
  end

  private
  def uploaded_file_params
    params.require(:uploaded_file).permit(:file_name, :comment, :file_data)
  end
end
