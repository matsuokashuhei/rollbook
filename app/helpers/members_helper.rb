module MembersHelper

  MEMBER_STATUS = Member::STATUS

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
