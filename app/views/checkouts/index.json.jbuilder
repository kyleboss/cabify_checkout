# frozen_string_literal: true

json.array! @checkouts, partial: 'checkouts/Checkout', as: :Checkout
