class RatePlacesController < ApplicationController
  before_action :authorize_request

  # TODO - api pagination
  def rates_by_place
    if params[:place_id].present?
      place = Place.find_by(maps_id: params[:place_id])

      if place.present?
        rate = RatePlace.find_by(place: place)

        render json: rate, status: :ok
      else
        render json: { errors: 'Place not found' },
             status: :not_found
      end
    else
      render json: { errors: 'Place id param can be blank' },
             status: :unprocessable_entity
    end
  end

  def create
    if params[:place_id].present? && params[:rate]
      place = Place.find_by(maps_id: params[:place_id])

      if place.present?
        rate = RatePlace.find_by(user: @current_user, place: place)
        begin
          if rate.present?
            rate.rate = params[:rate].to_f
            rate.comment = params[:comment]
            rate.save!
          else
            rate = RatePlace.create!(
              user: @current_user,
              place: place,
              rate: params[:rate].to_f,
              comment: params[:comment]
            )
          end

          render json: rate, status: :created
        rescue ActiveRecord::RecordInvalid => errors
          render json: { errors: errors.full_messages.to_sentence },
             status: :unprocessable_entity
        end
      else
        render json: { errors: 'Place not found' },
             status: :not_found
      end
    else
      render json: { errors: 'Place id and rate params can be blank' },
             status: :unprocessable_entity
    end
  end
end
