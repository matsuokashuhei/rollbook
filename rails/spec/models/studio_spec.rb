# == Schema Information
#
# Table name: studios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  note       :string(255)
#  school_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

require 'spec_helper'

describe Studio do
  pending "add some examples to (or delete) #{__FILE__}"
end
