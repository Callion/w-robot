# frozen_string_literal: true
# Documentation comment
module ErrorHelper
  def form_errors(errors)
    message = []
    errors.each do |_, error|
      message << error
    end
    message.join(' & ')
  end
end
