module ApplicationHelper
  def full_title sub_title
    base_title = "Car market"
    sub_title.empty? ? base_title : "#{sub_title} | #{base_title}"
  end
end
