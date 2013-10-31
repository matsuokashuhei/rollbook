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
