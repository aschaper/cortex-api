class ConditionsController < ApplicationController
  def create
    payload = params[:condition]
    event = Event.where(uuid: params[:event_id]).first

    condition = event.conditions.new(
      light:          payload[:light],
      temperature:    payload[:temperature],
      noise:          payload[:noise],
      moved:          payload[:moved]
    )

    if condition.save!
      status = 201
      response = {
        condition: condition.to_json
      }
    else
      status = 409
      response = {
        condition: []
      }
    end

    render json: response.to_json, status: status
  end
end
