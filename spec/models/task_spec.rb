# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  frequency  :string(255)
#  due_date   :date
#  status     :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Task do
  pending "add some examples to (or delete) #{__FILE__}"
end
