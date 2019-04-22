class Form::ConfigForm
  include ActiveModel::Model

  BOOLEAN_CONFIG = %i(
    can_signup
    can_upload
  ).freeze

  KEYS = BOOLEAN_CONFIG

  attr_accessor(*KEYS)

  def initialize(_attributes = {})
    super
    initialize_attributes
  end

  def save
    return false unless valid?

    KEYS.each do |key|
      value = instance_variable_get("@#{key}")
      config = Config.where(var: key).first_or_initialize(var: key)
      config.update(value: typecast_value(key, value))
    end
  end

  private

  def initialize_attributes
    KEYS.each do |key|
      instance_variable_set("@#{key}", Config.public_send(key)) if instance_variable_get("@#{key}").nil?
    end
  end

  def typecast_value(key, value)
    if BOOLEAN_CONFIG.include?(key)
      value == '1'
    else
      value
    end
  end
end
