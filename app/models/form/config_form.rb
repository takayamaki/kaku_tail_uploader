class Form::EventConfig
  include ActiveModel::Model

  delegate(
    :can_upload,
    to: Setting
  )
end
