# frozen_string_literal: true

json.array! @checkouts, partial: 'checkouts/checkout', as: :checkout
