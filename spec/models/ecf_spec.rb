# == Schema Information
#
# Table name: ecfs
#
#  id                              :bigint           not null, primary key
#  date                            :date
#  details                         :string
#  email                           :string
#  end_of_circumstances            :date
#  is_bereavement                  :boolean
#  is_deterioration_of_disability  :boolean
#  is_frequent_absence             :boolean
#  is_ongoing                      :boolean
#  is_other_exceptional_factors    :boolean
#  is_serious_short_term           :boolean
#  is_significant_adverse_personal :boolean
#  start_of_circumstances          :date
#  status                          :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
require 'rails_helper'

#Unit tests for ECFs

RSpec.describe Ecf, type: :model do
  describe "#id" do
    it "return ecf id" do
      ecf = described_class.new(id: 3)
      expect(ecf.id).to eq(3)
    end
  end

  describe "#date" do
    it "return ecf date" do
      ecf = described_class.new(date: 2022-03-21)
      expect(ecf.date).to eq(2022-03-21)
    end
  end

  describe "#details" do
    it "return ecf details" do
      ecf = described_class.new(details: "test")
      expect(ecf.details).to eq("test")
    end
  end

  describe "#email" do
    it "return ecf email" do
      ecf = described_class.new(email: "test@test.com")
      expect(ecf.email).to eq("test@test.com")
    end
  end

  describe "#end_of_circumstances" do
    it "return ecf end_of_circumstances" do
      ecf = described_class.new(end_of_circumstances: 2022-03-21)
      expect(ecf.end_of_circumstances).to eq(2022-03-21)
    end
  end
  
  describe "#is_bereavement" do
    it "return ecf is_bereavement" do
      ecf = described_class.new(is_bereavement: true)
      expect(ecf.is_bereavement).to eq(true)
    end
  end

  describe "#is_deterioration_of_disability" do
    it "return ecf is_deterioration_of_disability" do
      ecf = described_class.new(is_deterioration_of_disability: true)
      expect(ecf.is_deterioration_of_disability).to eq(true)
    end
  end

  describe "#is_frequent_absence" do
    it "return ecf is_frequent_absence" do
      ecf = described_class.new(is_frequent_absence: true)
      expect(ecf.is_frequent_absence).to eq(true)
    end
  end

  describe "#is_ongoing" do
    it "return ecf is_ongoing" do
      ecf = described_class.new(is_ongoing: true)
      expect(ecf.is_ongoing).to eq(true)
    end
  end

  describe "#is_other_exceptional_factors" do
    it "return ecf is_other_exceptional_factors" do
      ecf = described_class.new(is_other_exceptional_factors: true)
      expect(ecf.is_other_exceptional_factors).to eq(true)
    end
  end

  describe "#is_serious_short_term" do
    it "return ecf is_serious_short_term" do
      ecf = described_class.new(is_serious_short_term: true)
      expect(ecf.is_serious_short_term).to eq(true)
    end
  end

  describe "#is_significant_adverse_personal" do
    it "return ecf is_significant_adverse_personal" do
      ecf = described_class.new(is_significant_adverse_personal: true)
      expect(ecf.is_significant_adverse_personal).to eq(true)
    end
  end

  describe "#start_of_circumstances" do
    it "return ecf start_of_circumstances" do
      ecf = described_class.new(start_of_circumstances: 2022-03-21)
      expect(ecf.start_of_circumstances).to eq(2022-03-21)
    end
  end

  describe "#status" do
  it "return ecf status" do
    ecf = described_class.new(status: "test")
    expect(ecf.status).to eq("test")
  end
end

describe "#created_at" do
    it "return ecf unit created_at" do
      ecf = described_class.new(created_at: '1000-01-01 00:00:00')
      expect(ecf.created_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe "#updated_at" do
    it "return ecf unit updated_at" do
      ecf = described_class.new(updated_at: '1000-01-01 00:00:00')
      expect(ecf.updated_at).to eq('1000-01-01 00:00:00')
    end
  end

end
