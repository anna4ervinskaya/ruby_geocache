class GeoserviceController < ApplicationController
  def index
    @geos = Geolocation.all
  end
end
