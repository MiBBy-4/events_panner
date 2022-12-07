# frozen_string_literal: true

RSpec.describe 'Sign In' do
  let(:user) { create(:user, email: Faker::Internet.email, password: Faker::Internet.password) }
  let(:sign_in) { post '/api/v1/users/sessions', params: { user: attributes } }

  before do
    allow(Users::Api::V1::Session).to receive(:call).and_call_original
  end

  context 'with valid params' do
    let(:attributes) do
      { email: user.email, password: user.password }
    end

    it 'creates a new User' do
      expect { sign_in }.to change(User, :count).by(1)
    end

    it { expect(sign_in).to authenticate(user) }

    it 'receives session service' do
      sign_in

      expect(Users::Api::V1::Session).to have_received(:call)
    end
  end

  context 'with invalid params' do
    let(:attributes) do
      { email: user.email, password: 'testpassoword' }
    end

    it 'receives session service' do
      sign_in

      expect(Users::Api::V1::Session).to have_received(:call)
    end

    it { expect(sign_in).to be_an_invalid_api_request(ActiveRecord::RecordNotFound.to_s) }
  end
end
