# == Schema Information
#
# Table name: receipts
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  month      :string(255)
#  amount     :integer
#  method     :string(255)
#  date       :date
#  status     :string(255)
#  debit_id   :integer
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Receipt do
  pending "add some examples to (or delete) #{__FILE__}"
end
