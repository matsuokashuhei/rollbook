# == Schema Information
#
# Table name: bank_accounts
#
#  id               :integer          not null, primary key
#  holder_name      :string(255)
#  holder_name_kana :string(255)
#  bank_id          :string(255)
#  bank_name        :string(255)
#  branch_id        :string(255)
#  branch_name      :string(255)
#  account_number   :string(255)
#  status           :string(255)
#  note             :text
#  created_at       :datetime
#  updated_at       :datetime
#  receipt_date     :date
#  ship_date        :date
#  begin_date       :date
#  imperfect        :boolean
#  change_bank      :boolean
#

require 'spec_helper'

describe BankAccount do
  pending "add some examples to (or delete) #{__FILE__}"
end
