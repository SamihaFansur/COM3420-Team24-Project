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
class Ecf < ApplicationRecord
    # the many-to-one relation between unit codes and an ECF
    has_many :affected_units

    # allows the 'new ecf' form to set the attributes of new related affected_units
    # 'allow_destroy' lets the student remove an affected unit in the NEW form. [should not be able to remove once submitted,
    # test for this]
    accepts_nested_attributes_for :affected_units, allow_destroy: true

    has_many_attached :upload_medical_evidence, service: :db

    validates :upload_medical_evidence,content_type: {in: 'application/pdf', message: 'Please upload .pdf files only'} 
    #  presenceupload_medical_evidence in: 'application/pdf', message: 'is not a PDF' }
    # blob: { content_type: ['application/pdf'], message: 'not allowed'}
    

    # private
    # def upload_medical_evidence_file_type input
    #     upload_medical_evidence.each do |file|
    #         if !file.content_type.in?(%w(application/pdf))
    #             errors.add(:upload_medical_evidence, 'Please upload .pdf files only')
    #         end
    #     end
    # end


end
