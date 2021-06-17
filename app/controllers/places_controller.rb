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
            user: @current_user
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
    places = Place.order(:name).limit(20)

    render json: places, status: :ok
  end

  def map_list_places
    if params[:origin_id].present?
      begin
        place2 = Google::Maps.place("ChIJWwF7cl3qx0cRqYoFvgBsj00")
        place = Google::Maps.place("ChIJVXealLU_xkcRja_At0z9AGY")
        r = Google::Maps.route(place.address, place2.address)
        render json: { r: r.distance.value }, status: :ok
      rescue Google::Maps::ZeroResultsException => error
        render json: { errors: error }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Origin params can be blank' },
             status: :unprocessable_entity
    end
  end
end
