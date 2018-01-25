class GeolocationsController < ApplicationController
  before_filter :find_geolocation, :except => [:index, :create, :new]

  def find_geolocation
    @geolocation = Geolocation.find(params[:id])
  end

  def index
    @geolocations = Geolocation.all
  end

  def show
    render 'show'
  end

  def new
    @geolocation = Geolocation.new
  end

  def edit
    @geolocation = Geolocation.find(params[:id])
  end

  def create
    @geolocation = Geolocation.new(geolocation_get_params)

    if @geolocation.save
      redirect_to @geolocation
    else
      render 'new'
    end
  end

  def update

    if @geolocation.update(geolocation_get_params)
      redirect_to @geolocation
    else
      render 'edit'
    end
  end

  def destroy
    @geolocation.destroy
    redirect_to geolocations_path
  end

  private
    def geolocation_get_params
      params.require(:geolocation).permit(:message, :lat, :lng)
    end
end
