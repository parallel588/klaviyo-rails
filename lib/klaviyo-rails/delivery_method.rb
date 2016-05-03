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

      response = client.templates.render_and_send(klaviyo_message(mail))

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

      if message['from']
        @klaviyo_message[:from_email] = message['from'].addresses.first
        unless message['from'].display_names.compact.empty?
          @klaviyo_message[:from_name] = message['from'].display_names.compact.first
        end
      end

      @klaviyo_message
    end

    def client
      @client ||= ::Klaviyo::Client.new(settings[:secret_key], settings[:token])
    end
  end
end
