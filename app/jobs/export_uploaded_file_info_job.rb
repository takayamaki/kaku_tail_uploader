class ExportUploadedFileInfoJob < ApplicationJob
  queue_as :default
  def perform(file_id)
    begin
      file = UploadedFile.find(file_id)
      SpreadSheetExportor.instance.export_uploaded_file_info(file)
    rescue ActiveRecord::RecordNotFound
      true
    end
  end
end
