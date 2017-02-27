# frozen_string_literal: true
json.extract! automation, :id, :name, :active, :data, :created_at, :updated_at
json.url automation_url(automation, format: :json)
