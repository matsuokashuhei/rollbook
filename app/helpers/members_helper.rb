module MembersHelper

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
