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
FactoryBot.define do
  factory :user do
    mail { 'test@test.com' }
    givenname { 'test' }
    sn { 'test ' }
    ou { 'Undergraduates' }

    factory :student do
      uid { 'aca20sf' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 1 }
    end
    # second student login for tests
    factory :student2 do
      uid { 'aca20sg' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 1 }
      ou { 'COM' }
    end

    factory :student3 do
      uid { 'ab1ast' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 1 }
      ou { 'JNL' }
    end

    factory :module_leader do
      uid { 'aca20sf' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 2 }
    end

    # second student login for tests
    factory :module_leader2 do
      uid { 'aca20sg' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 2 }
    end
    factory :scrutiny_panel do
      uid { 'aca20sf' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 3 }
    end
    factory :admin do
      uid { 'aca20sf' }
      dn { 'uid=aca20sf,ou=Undergraduates,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk' }
      role { 4 }
    end
  end
end
