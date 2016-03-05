module BabyRabbitsHelper

  def list_item_text rabbit
    secondary_infos_tags = []

    rabbit.secondary_infos.each do |k, v|
      secondary_infos_tags << content_tag(:span, v, class: k)
    end

    secondary_infos_tags.join(" | ").html_safe
  end

end
