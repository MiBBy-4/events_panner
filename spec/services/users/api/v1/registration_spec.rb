# frozen_string_literal: true

RSpec.describe Users::Api::V1::Registration do
  subject(:instance) { described_class.new(params) }

  context 'with valid params' do
    let(:password) { Faker::Internet.password }
    let(:params) { { email: Faker::Internet.email, password: password, password_confirmation: password } }

    before do
      allow(Users::EventCategories::CreateDefault).to receive(:call)

      instance.call
    end

    it 'creates default categories for user' do
      expect(Users::EventCategories::CreateDefault).to have_received(:call).with(instance.value)
    end

    it 'creates an user' do
      expect(User.last).to eq(instance.value)
    end
  end

  context 'with invalid params' do
    let(:password) { Faker::Internet.password }
    let(:params) { { email: '', password: password, password_confirmation: password } }

    before do
      allow(Users::EventCategories::CreateDefault).to receive(:call)
    end

    it 'not creates new categories' do
      expect(Users::EventCategories::CreateDefault).not_to have_received(:call)
    end

    it 'not creates an user' do
      expect { instance.call }.not_to change(User, :count)
    end

    it 'has an error message' do
      instance.call

      expect(instance.error).to include("Email can't be blank")
    end
  end
end
