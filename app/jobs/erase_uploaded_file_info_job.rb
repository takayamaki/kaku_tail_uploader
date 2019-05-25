class EraseUploadedFileInfoJob < ApplicationJob
  queue_as :default
  def perform(user_id)
    SpreadSheetExportor.instance.erase_uploaded_file_info(user_id)
  end
end
