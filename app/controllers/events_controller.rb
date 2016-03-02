require './lib/push/apns'
require './lib/push/message'

class EventsController < ApplicationController

  def create
    uuid = SecureRandom.uuid
    event = Event.new
    event.uuid = uuid

    if event.save!
      status = 201
      response = {
        event: {
          uuid: uuid
        }
      }
    else
      response = {
        event: []
      }
      status = 409
    end

    render json: response.to_json, status: status
  end

  def latest
    event = Event.last
    summary = {
      event_id: event.uuid,
      sleep_score: event.sleep_score.to_s,
      start: event.conditions.first.created_at,
      stop: event.conditions.last.created_at,
      time_asleep: event.total_time_asleep.to_s,
      light: event.average_of(:light).round.to_s,
      temperature: event.average_of(:temperature).round.to_s,
      noise: event.average_of(:noise).round.to_s,
      movements: event.movements.map(&:created_at),
      date: event.created_at
    }

    render json: summary.to_json
  end

  def send_event_summary
    event = Event.where(uuid: params[:id]).first

    notification = ::Push::APNS.new(event)
    notification.send!
  end
end
