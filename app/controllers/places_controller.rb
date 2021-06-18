class PlacesController < ApplicationController
  before_action :authorize_request

  # TOD - com muita responsabilidade refatorar
  def create 
    if params[:place_id].present?
      place = Place.find_by(maps_id: params[:place_id])
      if place.present?
        render json: { errors: 'Place already exists.' },
             status: :conflict
      else
        begin
          place = Google::Maps.place(params[:place_id])
          new_place = Place.create!(
            name: place.name,
            address: place.address,
            maps_id: place.place_id,
            url: place.url,
            user: @current_user,
            latitude: place.latitude,
            longitude: place.longitude
          )
          render json: new_place, status: :created
        rescue Google::Maps::InvalidResponseException => error
          render json: { errors: error },
             status: :unprocessable_entity
        end
      end
    else
      render json: { errors: 'Place id params can be blank' },
             status: :unprocessable_entity
    end
  end

  def find_places
    if params[:search].present?
      places = Google::Maps.places(params[:search])
      render json: places, status: :ok
    else
      render json: { errors: 'Search params can be blank' },
             status: :unprocessable_entity
    end
  end

  # TODO - api pagination
  def list_places
    places = Place.order(:name).limit(10)

    render json: places, status: :ok
  end

  # TODO - api pagination
  # TOD - com muita responsabilidade refatorar
  def map_list_places
    if params[:origin_id].present?
      origin = Place.find_by(maps_id: params[:origin_id])
      if origin.present?
        places = Place.where.not(id: origin.id).limit(10)
        places_by_distance = {}

        places.each do |place|
          lat1 = origin.latitude
          lat2 = place.latitude
          log1 = origin.longitude
          log2 = place.longitude

          dist = DistanceService.new(lat1, lat2, log1, log2).call
          places_by_distance[place.id] = dist
        end
        ids = places_by_distance.sort_by{|k, v| v}.map{|id,v| id}
        
        render json: ids.collect {|i| Place.find(i) }, status: :ok
      else
        render json: { errors: 'Place not found' },
             status: :not_found
      end
    else
      render json: { errors: 'Origin params can be blank' },
             status: :unprocessable_entity
    end
  end
end
