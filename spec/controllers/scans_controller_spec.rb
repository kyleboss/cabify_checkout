# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe ScansController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Scan. As you add validations to Scan, be sure to
  # adjust the attributes here as well.
  let!(:actual_product) { FactoryBot.create(:product) }
  let!(:scan) { FactoryBot.create(:scan, quantity: 3, product: actual_product) }
  let!(:other_product) { FactoryBot.create(:product) }

  let(:valid_attributes) do
    {
      product_id: actual_product.id,
      checkout_id: scan.checkout.id,
      quantity: 3
    }
  end

  let(:invalid_attributes) { { quantity: 1 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ScansController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'POST #create' do
    context 'with valid params' do
      let(:scan_attrs) do
        valid_attributes.merge(product_id: other_product.id, product_identifier: other_product.barcode_number)
      end
      it 'creates a new Scan' do
        expect do
          post :create, params: { scan: scan_attrs }.merge(scan_attrs), session: valid_session
        end.to change(Scan, :count).by(1)
      end

      it 'be successful' do
        post :create, params: { scan: scan_attrs }.merge(scan_attrs), session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      it "not be successful" do
        post :create, params: { scan: invalid_attributes }, session: valid_session
        expect(response).to_not be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested scan' do
        scan = Scan.create! valid_attributes
        put :update, params: { id: scan.to_param, scan: new_attributes }, session: valid_session
        scan.reload
        skip('Add assertions for updated state')
      end

      it 'be successful' do
        scan = Scan.create! valid_attributes
        put :update, params: { id: scan.to_param, scan: valid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        scan = Scan.create! valid_attributes
        put :update, params: { id: scan.to_param, scan: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested scan' do
      scan = Scan.create! valid_attributes
      expect do
        delete :destroy, params: { id: scan.to_param }, session: valid_session
      end.to change(Scan, :count).by(-1)
    end

    it 'be successful' do
      scan = Scan.create! valid_attributes
      delete :destroy, params: { id: scan.to_param }, session: valid_session
      expect(response).to be_success
    end
  end
end
