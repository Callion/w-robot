# frozen_string_literal: true
# Documentation comment
class Automation < ActiveRecord::Base
  after_create :delayed_execution, if: :execute_at?
  after_update :delayed_execution, if: :execute_at_changed?

  belongs_to :user
  has_many :procedures

  validates :name, presence: true
  validates :user_id, presence: true
  validates :browser_type, presence: true
  validate :execute_at_in_future

  enum repetition: { never: 0, every_5_min: 1, every_hour: 2, every_day: 3, every_week: 4, every_month: 5 }

  accepts_nested_attributes_for :procedures,
                                allow_destroy: true,
                                reject_if: :all_blank

  private

  def execute_at_in_future
    if execute_at.present? && execute_at.to_date < Time.zone.now
      errors.add(:execute_at, "can't be in the past")
    end
  end

  def delayed_execution
    # TODO: Delayed Jobs incoming
  end
end
