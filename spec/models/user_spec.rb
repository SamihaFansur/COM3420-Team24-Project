# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :string
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :string
#  mail               :string
#  ou                 :string
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
require 'rails_helper'

#Unit tests for Users

RSpec.describe User, type: :model do
  
  describe "#id" do
    it "return user id" do
      user = described_class.new(id: 2)
      expect(user.id).to eq(2)
    end
  end

  describe "#current_sign_in_at" do
    it "return user current_sign_in_at" do
      user = described_class.new(current_sign_in_at: '1000-01-01 00:00:00')
      expect(user.current_sign_in_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe "#current_sign_in_ip" do
    it "return user current_sign_in_ip" do
      user = described_class.new(current_sign_in_ip: "test")
      expect(user.current_sign_in_ip).to eq("test")
    end
  end

  describe "#dn" do
    it "return user dn" do
      user = described_class.new(dn: "test")
      expect(user.dn).to eq("test")
    end
  end

  describe "#email" do
    it "return user email" do
      user = described_class.new(email: "test@test.com")
      expect(user.email).to eq("test@test.com")
    end
  end

  describe "#givenname" do
    it "return user givenname" do
      user = described_class.new(givenname: "test")
      expect(user.givenname).to eq("test")
    end
  end
  
  describe "#last_sign_in_at" do
    it "return user last_sign_in_at" do
      user = described_class.new(last_sign_in_at: '1000-01-01 00:00:00')
      expect(user.last_sign_in_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe "#last_sign_in_ip" do
    it "return user last_sign_in_ip" do
      user = described_class.new(last_sign_in_ip: "test")
      expect(user.last_sign_in_ip).to eq("test")
    end
  end

  describe "#mail" do
    it "return user mail" do
      user = described_class.new(mail: "test")
      expect(user.mail).to eq("test")
    end
  end

  describe "#ou" do
    it "return user ou" do
      user = described_class.new(ou: "test")
      expect(user.ou).to eq("test")
    end
  end

  describe "#sign_in_count" do
    it "return user sign_in_count" do
      user = described_class.new(sign_in_count: 1)
      expect(user.sign_in_count).to eq(1)
    end
  end

  describe "#sign_in_count" do
    it "return user sign_in_count" do
      user = described_class.new(sign_in_count: 1)
      expect(user.sign_in_count).to eq(1)
    end
  end
  
  describe "#sn" do
    it "return user sn" do
      user = described_class.new(sn: "test")
      expect(user.sn).to eq("test")
    end
  end

  describe "#uid" do
    it "return user uid" do
      user = described_class.new(uid: "test")
      expect(user.uid).to eq("test")
    end
  end

  describe "#username" do
    it "return user username" do
      user = described_class.new(username: "test")
      expect(user.username).to eq("test")
    end
  end

  describe "#created_at" do
    it "return user unit created_at" do
      user = described_class.new(created_at: '1000-01-01 00:00:00')
      expect(user.created_at).to eq('1000-01-01 00:00:00')
    end
  end

  describe "#updated_at" do
    it "return user unit updated_at" do
      user = described_class.new(updated_at: '1000-01-01 00:00:00')
      expect(user.updated_at).to eq('1000-01-01 00:00:00')
    end
  end

end
