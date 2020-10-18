class TestValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # actiontextのバリデーション
    # 現在はJSのみで制御。
  end
end