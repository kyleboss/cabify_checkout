# frozen_string_literal: true

json.array! @scans, partial: 'scans/scan', as: :scan
