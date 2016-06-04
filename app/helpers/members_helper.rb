module MembersHelper

  def course_members_link(course, disable: false)
    unless disable
      link_to t("activerecord.models.member"), course_members_path(@course)
    else
      link_to t("activerecord.models.member"), nil, class: "disabled"
    end
  end

  # セレクトボックス
  def options_of_member_status
    # 体験は設計ミスため削除する。
    #[["体験", "0"], ["入会", "1"], ["退会", "2"]]
    [["入会", "1"], ["退会", "2"]]
  end

  def display_gender(gender)
    { "M" => "男", "F" => "女" }[gender]
  end

end
