# frozen_string_literal: true
# Documentation comment
class Procedure < ActiveRecord::Base
  belongs_to :automation

  validates :action, presence: true
  validates :position, presence: true, uniqueness: { scope: :automation }

  enum category: { div: 0, button: 1, text_field: 2, textarea: 3, element: 4 }
  enum selector: { id: 0, css: 1, xpath: 2, klass: 3, klass_name: 4, placeholder: 5 }
  enum action: { click: 0, set: 1, send_keys: 2, append: 3, goto: 4, text: 5 }

  scope :by_position, -> { order(:position) }

  def script
    [element_search, element_action].reject(&:blank?).join('.')
  end

  def element_search
    return '' if category.blank?
    "#{category}(#{to_html_tag(selector)}: '#{path}')"
  end

  def element_action
    return action if input.blank?
    "#{action} '#{input}'"
  end

  def to_html_tag(enum)
    {
      klass: 'class',
      klass_name: :name
    }[enum.to_sym] || enum
  end
end
