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
#  role               :integer          default(0)
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
class User < ApplicationRecord
  include EpiCas::DeviseHelper

  has_many :user_modules
  accepts_nested_attributes_for :user_modules, allow_destroy: true

  enum role: {guest: 0, student: 1, module_leader: 2, scrutiny: 3, admin: 4}

  def generate_attributes_from_ldap
    self.username = self.uid
    self.email = self.mail
    self.first_name = self.givenname
    self.last_name = self.sn
    self.department_code = self.ou
    self.person_code = self.dn
    super
  end
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  end
