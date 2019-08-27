require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid factory' do
    it 'has a valid valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
end
