# frozen_string_literal: true
# Documentation comment
class Automation < ActiveRecord::Base
  belongs_to :user
  has_many :procedures

  validates :name, presence: true
  validates :user_id, presence: true
  validates :browser_type, presence: true

  accepts_nested_attributes_for :procedures,
                                allow_destroy: true,
                                reject_if: :all_blank
end
