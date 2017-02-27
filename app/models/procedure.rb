# frozen_string_literal: true
# Documentation comment
class Procedure < ActiveRecord::Base
  belongs_to :automation

  validates :script, presence: true
  validates :position, presence: true, uniqueness: { scope: :automation }

  scope :by_position, -> { order(:position) }
end
