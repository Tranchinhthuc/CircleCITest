module OfficesHelper
  def get_city_id_from city_param
    if city_param.present?
      city = City.find(city_param)
    else
      city = City.first
    end
  end
end
