# == Schema Information
#
# Table name: affected_units
#
#  id               :bigint           not null, primary key
#  assessment_type  :string
#  date_from        :date
#  date_to          :date
#  requested_action :string
#  unit_code        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ecf_id           :integer
#
# Indexes
#
#  index_affected_units_on_ecf_id  (ecf_id)
#
require 'rails_helper'

RSpec.describe AffectedUnit, type: :model do
  describe '#id' do
    it 'return affected unit id' do
      affected_unit = described_class.new(id: '5')
      expect(affected_unit.id).to eq(5)
    end
  end

  describe '#assessment_type' do
    it 'return affected unit assessment_type' do
      affected_unit = described_class.new(assessment_type: 'test')
      expect(affected_unit.assessment_type).to eq('test')
    end
  end

  describe '#date_from' do
    it 'return affected unit date_from' do
      affected_unit = described_class.new(date_from: 2022 - 0o3 - 21)
      expect(affected_unit.date_from).to eq(2022 - 0o3 - 21)
    end
  end

  describe '#date_to' do
    it 'return affected unit date_to' do
      affected_unit = described_class.new(date_to: 2022 - 0o3 - 21)
      expect(affected_unit.date_to).to eq(2022 - 0o3 - 21)
    end
  end

  describe '#requested_action' do
    it 'return affected unit requested_action' do
      affected_unit = described_class.new(requested_action: 'test')
      expect(affected_unit.requested_action).to eq('test')
    end
  end

  describe '#unit code' do
    it 'return affected unit unit code' do
      affected_unit = described_class.new(unit_code: 'test')
      expect(affected_unit.unit_code).to eq('test')
    end
  end

  describe '#created_at' do
    it 'return affected unit created_at' do
      affected_unit = described_class.new(created_at: '1000-01-01 00:00:00')
      expect(affected_unit.created_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe '#updated_at' do
    it 'return affected unit updated_at' do
      affected_unit = described_class.new(updated_at: '1000-01-01 00:00:00')
      expect(affected_unit.updated_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe '#ecf_id' do
    it 'return affected unit ecf_id' do
      affected_unit = described_class.new(ecf_id: 3)
      expect(affected_unit.ecf_id).to eq(3)
    end
  end
end
