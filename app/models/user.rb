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
#  role               :integer          default("guest")
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

  has_many :ecfs
  has_many :user_modules
  accepts_nested_attributes_for :user_modules, allow_destroy: true

  enum role: { guest: 0, student: 1, module_leader: 2, scrutiny: 3, admin: 4 }

  def generate_attributes_from_ldap
    self.username = uid
    self.email = mail
    self.first_name = givenname
    self.last_name = sn
    self.department_code = ou
    self.person_code = dn
    super
  end

  # this sets role before a database CREATE executes.
  before_create do
    # only sets role > 0 if the user being created is a student according to sheffield_ldap
    self.role = 1 if dn.include? 'ou=Students' and guest?
  end
end
