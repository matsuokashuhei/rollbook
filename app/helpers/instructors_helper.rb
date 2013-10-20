module InstructorsHelper
  def instructors_link
    link_to t("activerecord.models.instructor"), instructors_path
  end
end
