# frozen_string_literal: true
# Documentation comment
module ScriptHelper
  def form_coloring(broken)
    if broken
      'invalid'
    elsif broken == false
      'valid'
    end
  end
end
