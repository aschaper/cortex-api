require 'houston'

module Push
  class Message
    def initialize(event)
      @event = event
    end

    def sleep_summary_message
      sleep_score = @event.sleep_score
      message = ""

      message += "Well done! " if sleep_score >= 8

      message += "You slept for #{@event.total_time_asleep} hours and your sleep score is #{sleep_score}."

      message
    end
  end
end
