# frozen_string_literal: true
class Category < ActiveRecord::Base
  has_many :automations

  validates :name, :color, presence: true

  scope :by_priority, -> { order('priority DESC, name') }
end
