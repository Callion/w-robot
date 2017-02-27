# frozen_string_literal: true
# Documentation comment
class ApplicationController < ActionController::Base
  include ErrorHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
