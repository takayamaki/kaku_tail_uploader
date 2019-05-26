# == Schema Information
#
# Table name: settings
#
#  id         :bigint(8)        not null, primary key
#  thing_type :string(30)
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thing_id   :integer
#
# Indexes
#
#  index_settings_on_thing_type_and_thing_id_and_var  (thing_type,thing_id,var) UNIQUE
#

# RailsSettings Model
class Config < RailsSettings::Base
  source Rails.root.join("config/default_config.yml")
end
