module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_sym)} fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message.capitalize
      end)
    end
    nil
  end

  def icon_link_to icon_name, href, options = {}
    link_to content_tag(:i, icon_name, class: "material-icons"), href, options
  end

  def color_by_cage cage
    return "#388E3C" if cage.nil?

    puts "cage.type => #{cage.type}"

    case cage.type
    when "FatteningCage"
      "#FF5722"
    when "MotherhoodCage"
      "#E91E63"
    when "WeaningCage"
      "#FFC107"
    when "RaceCage"
      "#3F51B5"
    else
      "#388E3C"
    end
  end

end
