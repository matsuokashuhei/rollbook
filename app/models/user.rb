# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  role                   :string(255)
#  status                 :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable
  has_many :access_logs

  ROLES = {
    SYSTEM: "0",
    ADMIN: "1",
    MANAGER: "2",
    STAFF: "3",
  }
  STATUSES = {
    ACTIVE: "1",
    NONACTIVE: "0",
  }

  def timeout_in
    60.minutes
  end

  def admin?
    role <= ROLES[:ADMIN]
  end

  def manager?
    role <= ROLES[:MANAGER]
  end

  def staff?
    role <= ROLES[:STAFF]
  end

  def active?
    status == STATUSES[:ACTIVE]
  end

  def delete?
    unless self.admin?
      true
    else
      false
    end
  end

end
