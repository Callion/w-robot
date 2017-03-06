# frozen_string_literal: true
# Documentation comment
class ApplicationController < ActionController::Base
  include ErrorHelper
  before_filter :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
