module EducationsHelper
  def location_date location, from_date, to_date
    location_date_array = []
    location_date_array << location unless location.blank?
    location_date_array << "#{from_date} - #{to_date}" if !from_date.blank? and !to_date.blank?
    location_date_array.join(", ")
  end
end
