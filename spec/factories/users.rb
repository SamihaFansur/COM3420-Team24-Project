# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  current_sign_in_at  :datetime
#  current_sign_in_ip  :string
#  dn                  :string
#  dob                 :date
#  email               :string           default(""), not null
#  givenname           :string
#  is_student_visa     :boolean
#  last_sign_in_at     :datetime
#  last_sign_in_ip     :string
#  level_of_study      :string
#  mail                :string
#  ou                  :string
#  programme_of_study  :string
#  registration_number :integer
#  role                :integer          default("guest")
#  sign_in_count       :integer          default(0), not null
#  signature           :string
#  sn                  :string
#  uid                 :string
#  username            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
FactoryBot.define do
  factory :user do
      uid { "arb20eg" }
      mail { "test@test.com" }
      givenname { "test" }
      sn { "test "}
      ou { "Undergraduates" }

    factory :student do
      dn {"uid=aca20sf,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      role {1}

    end
    factory :staff do
      dn {"uid=aca20sf,ou=Undergraduates,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk"}
      role {4}
    end
  end
end
