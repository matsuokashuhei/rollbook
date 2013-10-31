# == Schema Information
#
# Table name: debits
#
#  id              :integer          not null, primary key
#  bank_account_id :integer
#  amount          :integer
#  status          :string(255)
#  note            :text
#  created_at      :datetime
#  updated_at      :datetime
#  tuition_id      :integer
#

require 'spec_helper'

describe Debit do
  pending "add some examples to (or delete) #{__FILE__}"
end
