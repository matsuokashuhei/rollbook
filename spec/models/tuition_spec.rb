# == Schema Information
#
# Table name: tuitions
#
#  id             :integer          not null, primary key
#  month          :string(255)
#  debit_status   :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#  receipt_status :string(255)
#

require 'spec_helper'

describe Tuition do
  pending "add some examples to (or delete) #{__FILE__}"
end
