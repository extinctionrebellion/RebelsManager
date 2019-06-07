class Email < ActiveRecord::Base
  include ActiveModel::Conversion

  attr_accessor :all_rebels, :rebel_ids, :subject, :message, :error_message

  has_rich_text :message

  def valid?
    set_error_message_if_no_rebel unless rebel_ids&.any?
    rebel_ids&.any? and !subject.empty?
  end

  def set_error_message_if_no_rebel
    self.error_message = "You must choose at least one rebel to email."
  end
end
