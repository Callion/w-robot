# frozen_string_literal: true
# Documentation comment
class Automation < ActiveRecord::Base
  after_create :queve_execution, if: :execute_at?
  after_update :queve_execution, if: :execute_at_changed?

  belongs_to :user
  has_many :procedures

  validates :name, presence: true
  validates :user_id, presence: true
  validates :browser_type, presence: true
  validate :execute_at_in_future

  enum repetition: { every_5_min: 1, every_hour: 2, every_day: 3, every_week: 4, every_month: 5 }

  accepts_nested_attributes_for :procedures,
                                allow_destroy: true,
                                reject_if: :all_blank

  private

  def execute_at_in_future
    return unless execute_at.present? && execute_at < Time.zone.now
    errors.add(:execute_at, "can't be in the past")
  end

  def queve_execution
    job = Delayed::Job.where(automation_id: id, locked_at: nil).take
    return job.delete if job.present? && execute_at.nil?
    return if execute_at.nil?
    if !job.present?
      job = self.delay(run_at: execute_at, automation_id: id).execute
    else
      job.update(run_at: execute_at)
    end
  end

  def execute
    browser = Html::BrowserBuilder.new(browser_type).build
    executor = Automations::Executor.new(self, browser)
    if executor.run
      next_execution if repetition.present?
    else
      # TODO: Send mail with unsuccesfull try
    end
  end

  def next_execution
    time = ''
    case repetition
    when 'every_5_min'
      time = execute_at + 5.minutes
    when 'every_hour'
      time = execute_at + 1.hours
    when 'every_day'
      time = execute_at + 1.days
    when 'every_week'
      time = execute_at + 1.weeks
    when 'every_month'
      time = execute_at + 1.months
    end
    update(execute_at: time)
  end
end
