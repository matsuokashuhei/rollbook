# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  zip        :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

require 'spec_helper'

describe School do
  pending "add some examples to (or delete) #{__FILE__}"
end
