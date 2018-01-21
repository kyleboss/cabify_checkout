# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScansController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/scans').to route_to('scans#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/scans/1').to route_to('scans#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/scans/1').to route_to('scans#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/scans/1').to route_to('scans#destroy', id: '1')
    end
  end
end
