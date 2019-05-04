class UploadedFilesController < ApplicationController
  include RequireAuthenticateConcern
  before_action :check_able_to_upload, only: [:new]

  def index
    if current_user.staff?
      @uploaded_files = UploadedFile.all
      @uploaded_files = @uploaded_files.by_upload_user_id(params[:user_id]) if params[:user_id]
    else
      @uploaded_files = UploadedFile.by_upload_user_id(current_user.id)
    end

    @uploaded_files = @uploaded_files.reverse_order.page(params[:page])

    if Config.can_upload != "1"
      @message = I18n.t('uploaded_files.index.out_of_submission_period_warning')
    elsif current_user.uploaded_file.present?
      @message = I18n.t('uploaded_files.index.file_already_exists_warning')
    end
  end

  def new
    @uploaded_file = current_user.build_uploaded_file
    render layout: 'layouts/upload_form'
  end


  def create
    @uploaded_file = current_user.create_uploaded_file(uploaded_file_params)

    if @uploaded_file.save
      redirect_to @uploaded_file, notice: 'Uploaded file was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.staff?
      target = UploadedFile.find(params[:id])
    else
      target = current_user.uploaded_file
    end
    not_found unless target.present?

    target.destroy!
    redirect_to uploaded_files_path
  end

  def show
    if current_user.staff?
      @uploaded_file = UploadedFile.find(params[:id])
    else
      @uploaded_file = current_user.uploaded_file
    end
    not_found unless @uploaded_file.present?
  end

  private
  def uploaded_file_params
    params.require(:uploaded_file).permit(
      :file_name, :comment, :file_data,
      :thumbnail_sec_part, :thumbnail_frame_part,
      :start_of_15sec_sec_part, :start_of_15sec_frame_part,
      :start_of_30sec_sec_part, :start_of_30sec_frame_part,
      :start_of_60sec_sec_part, :start_of_60sec_frame_part)
  end

  def check_able_to_upload
    forbidden if Config.can_upload == "0"
  end
end
