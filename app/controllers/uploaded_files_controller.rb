class UploadedFilesController < ApplicationController
  include RequireAuthenticateConcern

  def index
    @uploaded_files = UploadedFile.all
  end

  def new
  end

  def destroy
  end

  def show
  end
end
