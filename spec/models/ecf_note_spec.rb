# == Schema Information
#
# Table name: ecf_notes
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ecf_id      :integer
#  user_id     :integer
#
# Foreign Keys
#
#  fk_rails_...  (ecf_id => ecfs.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe EcfNote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
