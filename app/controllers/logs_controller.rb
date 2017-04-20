# frozen_string_literal: true
class LogsController < ApplicationController
  def index
    @logs = current_user.logs.order('created_at DESC')
  end
end
