# == Schema Information
#
# Table name: user_modules
#
#  id          :bigint           not null, primary key
#  module_code :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :string
#
require 'rails_helper'

RSpec.describe UserModule, type: :model do
  describe '#id' do
    it 'return user_module id' do
      user_module = described_class.new(id: 3)
      expect(user_module.id).to eq(3)
    end
  end

  describe '#module_code' do
    it 'return user_module module_code' do
      user_module = described_class.new(module_code: 'COM2008')
      expect(user_module.module_code).to eq('COM2008')
    end
  end

  describe '#created_at' do
    it 'return user_module created_at' do
      user_module = described_class.new(created_at: '1000-01-01 00:00:00')
      expect(user_module.created_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe '#updated_at' do
    it 'return user_module updated_at' do
      user_module = described_class.new(updated_at: '1000-01-01 00:00:00')
      expect(user_module.updated_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe '#user_id' do
    it 'return user_module id' do
      user_module = described_class.new(user_id: '3')
      expect(user_module.user_id).to eq('3')
    end
  end
end
