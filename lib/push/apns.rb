module Push
  class APNS
    APNS_TOKEN = ENV["APNS_TOKEN"]

    def initialize(event)
      raise "You must supply an Event instance" unless event.is_a? Event

      @event = event
      @houston = Houston::Client.development
      @houston.certificate = File.read("config/certificates/apple_push_notification.pem")
    end

    def send!
      notification = Houston::Notification.new(device: APNS_TOKEN)
      message = Push::Message.new(@event)

      notification.alert = message.sleep_summary_message

      @houston.push(notification)
    end
  end
end
