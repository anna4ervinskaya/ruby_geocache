class GeoApiController < ApplicationController
  include GeoserviceHelper
  skip_before_action :verify_authenticity_token
  before_filter :find_geolocation, :except => [:index, :create, :closest, :in_radius]
  def find_geolocation
    @geolocation = Geolocation.find(params[:id])
  end

  def index
    @geolocations = Geolocation.all
    respond_to do |format|
      format.json { render json: {data: @geolocations} , status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @geolocation, status: :ok }
    end
  end

  def create
    @geolocation = Geolocation.new(geolocation_get_params)
    respond_to do |format|
      if @geolocation.save
        format.json { render json: @geolocation, status: :created }
      else
        format.json { render json: @geolocation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @geolocation.update_attributes(geolocation_get_params)
        format.json { render json: @geolocation, status: :ok }
      else
        format.json { render json: @geolocation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @geolocation.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @geolocation.errors, status: :unprocessable_entity }
      end
    end
  end

  def closest
    closest = find_closest(params[:lat],params[:lng])
    respond_to do |format|
      format.json { render json: closest }
    end
  end

  def in_radius
    markers_in_radius = find_in_radius(params[:lat],params[:lng])
    respond_to do |format|
      format.json { render json: {markers: markers_in_radius} }
    end
  end

  private
    def geolocation_get_params
      params.permit(:message, :lat, :lng)
    end
end
