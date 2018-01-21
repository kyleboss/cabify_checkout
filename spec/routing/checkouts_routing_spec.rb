# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckoutsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/checkouts/new').to route_to('checkouts#new')
    end

    it 'routes to #create' do
      expect(post: '/checkouts').to route_to('checkouts#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/checkouts/1').to route_to('checkouts#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/checkouts/1').to route_to('checkouts#update', id: '1')
    end
  end
end
