# frozen_string_literal: true

RSpec.describe Users::Api::V1::Session do
  subject(:instance) { described_class.new(params) }

  let(:user) { create(:user) }

  before do
    instance.call
  end

  context 'with valid params' do
    let(:params) { { email: user.email, password: user.password } }

    it 'finds and returns user' do
      expect(instance.value).to eq(user)
    end
  end

  context 'with invalid params' do
    let(:params) { { email: user.email, password: '' } }

    it 'has an error' do
      expect(instance.error).to eq(ActiveRecord::RecordNotFound)
    end
  end
end
