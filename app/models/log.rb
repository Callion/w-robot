# frozen_string_literal: true
class Log < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
end
