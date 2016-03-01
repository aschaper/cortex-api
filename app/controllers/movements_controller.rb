class MovementsController < ApplicationController
  def create
    event = Event.where(uuid: params[:event_id]).first

    if event.movements.create
      status = 201
      response = {
        movements: event.movements.size
      }
    else
      status = 409
      response = {
        movements: []
      }
    end

    render json: response.to_json, status: status
  end
end
