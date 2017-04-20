# frozen_string_literal: true
class User < ActiveRecord::Base
  has_many :automations
  has_many :logs

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
