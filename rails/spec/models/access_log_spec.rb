# == Schema Information
#
# Table name: access_logs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  ip             :string(255)
#  remote_ip      :string(255)
#  request_method :string(255)
#  fullpath       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe AccessLog do
  pending "add some examples to (or delete) #{__FILE__}"
end
