require 'geocoder'
module GeoserviceHelper
  def find_in_radius(lat,lng)
    radius_km = 100
    result_markers = []
    geolocations = Geolocation.all
    geolocations.each do |geol|
      distance_from_location = calculate_distance_in_km([geol.lat, geol.lng], [lat, lng])
      if distance_from_location <= radius_km
        result_markers.push(geol)
      end
    end
    return result_markers
  end

  def find_closest(lat,lng)
    r = 6371
    distances = []
    closest = -1
    geolocations = Geolocation.all
    i = 0
    geolocations.each do |geol|
      distances[i] = calculate_distance_in_km([geol.lat, geol.lng], [lat, lng])
      if  closest == -1 or distances[i] < distances[closest]
        closest = i;
      end
      i = i+1
    end
    if closest != -1 and geolocations[closest]
      return geolocations[closest]
    else
      return nil
    end

  end
  private
    def rad(x)
      x * Math::PI / 180
    end
    def calculate_distance_in_km (aLocation,bLocation)
      return Geocoder::Calculations.distance_between(aLocation, bLocation) * 1.60934
    end
end
