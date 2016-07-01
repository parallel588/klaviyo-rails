require 'klaviyo'

module KlaviyoRails
  class DeliveryMethod
    attr_accessor :settings
    def initialize(options = {})
      self.settings = {
        secret_key: ENV['KLAVIYO_SECRET_KEY'],
        token: ENV['KLAVIYO_TOKEN']
      }.merge(options)
    end

    def deliver!(mail)
      if mail['as_event'] && mail['as_event'].value.to_s == 'true'
        response = client.event.track(
          event_name: mail['event_name'].value,
          customer_properties: {
            '$email': mail['to'].to_s
          },
          properties: {
            email: mail['to'].to_s,
            '$event_id': mail.object_id,
            date: Time.current,
            context: JSON.load(mail['context'].value),
            subject: mail['subject'].to_s,
            to: mail['to'].to_s,
            from:{
                    name: from_name(mail),
                    email: from_email(mail)
                  }
          }
        )
      else
        response = client.templates.render_and_send(klaviyo_message(mail))
      end

      if settings[:return_response]
        response
      else
        self
      end
    end

    private

    def klaviyo_message(message)
      @klaviyo_message = {
        id: message['template_id'].value,
        context: message['context'].value,
        service: settings.fetch(:service) { 'klaviyo' },
        subject: message['subject'].to_s,
        to: message['to'].to_s
      }

      @klaviyo_message[:from_email] = from_email(message) if from_email(message)
      @klaviyo_message[:from_name] = from_name(message) if from_name(message)

      @klaviyo_message
    end

    def from_email(message)
      @from_email ||= message['from'] && message['from'].addresses.first
    end

    def from_name(message)
      @from_name ||
        begin
          unless message['from'].display_names.compact.empty?
            @from_name = message['from'].display_names.compact.first
          end
        end
      @from_name
    end

    def client
      @client ||= ::Klaviyo::Client.new(settings[:secret_key], settings[:token])
    end
  end
end
