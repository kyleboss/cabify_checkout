# frozen_string_literal: true

json.extract! checkout, :id, :created_at, :updated_at
json.url checkout_url(checkout, format: :json)
