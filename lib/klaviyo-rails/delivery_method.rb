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
      response = client.invoke(
        :templates,
        :render_and_send,
        id: mail['template_id'].value,
        context: mail['context'].value,
        service: settings.fetch(:service) { 'klaviyo' },
        from_email: mail['from'].to_s,
        from_name:  mail['from'].display_names.first,
        subject: mail['subject'].to_s,
        to: mail['to'].to_s
      )

      if settings[:return_response]
        response
      else
        self
      end
    end

    private

    def client
      @client ||= ::Klaviyo::Client.new(settings[:secret_key], settings[:token])
    end
  end
end
