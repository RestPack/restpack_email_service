require 'sidekiq'
require 'mail'

module Jobs::Email
  class SendRaw
    include Sidekiq::Worker

    def perform(params)
      params.deep_symbolize_keys!
      configuration = get_configuration(params)

      Mail.defaults do
        delivery_method :smtp, {
          address:              configuration[:smtp_server],
          port:                 configuration[:smtp_port],
          user_name:            configuration[:smtp_username],
          password:             configuration[:smtp_password],
          enable_starttls_auto: true
        }
      end

      mail = Mail.new do
        to params[:to]
        from params[:from] || configuration[:default_from]
        subject params[:subject]

        text_part do
          body params[:text_body]
        end

        if params[:html_body]
          html_part do
            content_type 'text/html; charset=UTF-8'
            body params[:html_body]
          end
        end
      end

      mail.deliver
    end

    private

    def get_configuration(params)
      config = Serializers::Email::Configuration.resource(
        application_id: params[:application_id]
      )[:configurations]

      raise "Email is not setup for this application" if config.empty?
      return config.first
    end
  end
end
