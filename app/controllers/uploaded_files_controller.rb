class UploadedFilesController < ApplicationController
  include RequireAuthenticateConcern

  def index
    @uploaded_files = UploadedFile.all
  end

  def new
    @uploaded_file = current_user.uploaded_file.build
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
    p params.require(:uploaded_file).permit(:file_name, :comment)
  end
end
