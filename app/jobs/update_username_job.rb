class UpdateUsernameJob < ApplicationJob
  queue_as :default
  def perform(user_id)
    begin
      user = User.find(user_id)
      SpreadSheetExportor.instance.update_username(user)
    rescue ActiveRecord::RecordNotFound
      true
    end
  end
end
