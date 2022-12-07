# frozen_string_literal: true

RSpec.describe 'Sign Up' do
  let(:sign_up) { post '/api/v1/users/registrations', params: { user: attributes } }

  before do
    allow(Users::Api::V1::Registration).to receive(:call).and_call_original
  end

  context 'with valid params' do
    let(:password) { Faker::Internet.password }
    let(:attributes) do
      { email: Faker::Internet.email, password: password, password_confirmation: password }
    end

    it 'receives registrations service' do
      sign_up

      expect(Users::Api::V1::Registration).to have_received(:call)
    end

    it 'creates a new User' do
      expect { sign_up }.to change(User, :count).by(1)
    end

    it { expect(sign_up).to authenticate(User.last) }
  end

  context 'with invalid params' do
    let(:attributes) do
      { email: '', password: 'testpassoword', password_confirmation: 'anotherpassword' }
    end

    it 'not creates a new User' do
      expect { sign_up }.not_to change(User, :count)
    end

    it 'receives registrations service' do
      sign_up

      expect(Users::Api::V1::Registration).to have_received(:call)
    end

    it { expect(sign_up).to be_an_invalid_api_request("Email can't be blank") }
  end
end
