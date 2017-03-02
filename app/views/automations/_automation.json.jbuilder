# frozen_string_literal: true
json.extract! automation, :id, :name, :active, :browser_type, :created_at, :updated_at
json.url automation_url(automation, format: :json)
