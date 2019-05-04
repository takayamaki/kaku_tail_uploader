class PreviewPointValidator < ActiveModel::Validator
  def validate(record)
    check_include_shorter_section(record, 450, 'thumbnail', 'start_of_15sec')
    check_include_shorter_section(record, 900, 'thumbnail', 'start_of_30sec')
    check_include_shorter_section(record, 450, 'start_of_15sec', 'start_of_30sec')
    check_include_shorter_section(record, 1800, 'thumbnail', 'start_of_60sec')
    check_include_shorter_section(record, 1350, 'start_of_15sec', 'start_of_60sec')
    check_include_shorter_section(record, 900, 'start_of_30sec', 'start_of_60sec')
  end

  private
  def check_include_shorter_section(record, allowdDiff, shorterAttrName, longerAttrName)
    add_not_include_error(record, shorterAttrName, longerAttrName) unless include_section?(record, allowdDiff, shorterAttrName, longerAttrName)
  end

  def include_section?(record, allowdDiff, shorterAttrName, longerAttrName)
    shorterSectionByFrame = record.send("#{shorterAttrName}_by_frame")
    longerSectionByFrame = record.send("#{longerAttrName}_by_frame")

    (0 .. allowdDiff).include? shorterSectionByFrame - longerSectionByFrame
  end

  def add_not_include_error(record, shorterAttrName, longerAttrName)
    record.errors.add(
      :base,
      I18n.t('uploaded_files.new.error_not_include',
        shorter: I18n.t("uploaded_files.shared.#{shorterAttrName}"),
        longer: I18n.t("uploaded_files.shared.#{longerAttrName}")
      )
    )
  end
end
