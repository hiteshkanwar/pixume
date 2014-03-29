module ApplicationHelper
  def flashes
    if !notice.blank? or !alert.blank?
      close_button = "<button type='button' data-dismiss='alert' class='close'>x</button>"
      return content_tag(:div, (close_button + notice).html_safe, :class => "alert alert-success") unless notice.blank?
      return content_tag(:div, (close_button + alert).html_safe, :class => "alert") unless alert.blank?
    end
  end
  
  def errors_for objekt
    errors = objekt.errors.full_messages
    return '' if errors.blank?
    err_string = ''
    if errors.include?("Password doesn't match confirmation")
      errors.delete("Password doesn't match confirmation")
      errors << "Password and Password confirmation doesn't match"
    end
    errors.each do |e|
      err_string += content_tag(:li, e)
    end
    content_tag(:ul, err_string.html_safe, :class => "errors")
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def flash_ajax_msg alert_type, message
    alert_class = alert_type == 'success' ? 'alert alert-success' : 'alert'
    close_button = "<button type='button' data-dismiss='alert' class='close'>x</button>"
    return content_tag(:div, (close_button + message).html_safe, :class => alert_class)
  end
  
  def months_for_select
    (1..12).collect{|m| [ Date::MONTHNAMES[m], m]}
  end
   
end
