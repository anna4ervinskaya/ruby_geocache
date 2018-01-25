class GeoChannel < ApplicationCable::Channel
  include GeoserviceHelper
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def subscribed
    stream_from "GeoChannel"
    ActionCable.server.broadcast("GeoChannel", {list: Geolocation.all.map{|gl| {lat: gl.lat, lng: gl.lng, message: gl.message}}})
  end

  def receive(data)
    if data["new"]
      geolocation = Geolocation.new(lat: data["new"]["lat"], lng: data["new"]["lng"], message: data["new"]["message"])
      ActionCable.server.broadcast("GeoChannel", {saved: geolocation.save})
    end
    if data["find_close"]
      closest = find_closest(data["find_close"]["lat"],data["find_close"]["lng"])
      ActionCable.server.broadcast("GeoChannel", {closest: closest})
    end
    if data["find_in_radius"]
      in_radius = find_in_radius(data["find_in_radius"]["lat"],data["find_in_radius"]["lng"])
      ActionCable.server.broadcast("GeoChannel", {in_radius: in_radius})
    end
  end
end
