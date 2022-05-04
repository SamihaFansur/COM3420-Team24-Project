# == Schema Information
#
# Table name: ecfs
#
#  id                              :bigint           not null, primary key
#  date                            :date
#  details                         :string
#  email                           :string
#  end_of_circumstances            :date
#  highly_sensitive                :boolean
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
#  user_id                         :integer
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Ecf < ApplicationRecord
    belongs_to :user

    has_many :agendas
    has_many :meetings, through: :agendas

    # the many-to-one relation between unit codes and an ECF
    has_many :affected_units
    has_many :ecf_notes
    has_many :decisions, through: :agendas
    validates :affected_units, presence: true
    validates_associated :affected_units

    has_many_attached :upload_medical_evidence, service: :db
    validates :upload_medical_evidence, content_type: {in: 'application/pdf', message: 'Please upload .pdf files only'} 

    has_many_attached :upload_conversations

    validates :details, presence: true
    validates :end_of_circumstances, presence: true, date: { after_or_equal_to:  :start_of_circumstances}, unless: :is_ongoing 
    # allows the 'new ecf' form to set the attributes of new related affected_units
    # 'allow_destroy' lets the student remove an affected unit in the NEW form. [should not be able to remove once submitted,
    # test for this]
    accepts_nested_attributes_for :affected_units, allow_destroy: true
    accepts_nested_attributes_for :ecf_notes, allow_destroy: true

    after_initialize :set_pending_status

    def set_pending_status
      self.status  ||= "Pending"        #will set the default value only if it's nil
    end
    

end
