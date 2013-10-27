require 'sidekiq'
require 'mail'

module RestPack::Email::Service::Jobs
  module Email
    class SendRaw
      include Sidekiq::Worker

      def perform(params)
        params.deep_symbolize_keys!
        settings = email_settings(params)

        Mail.defaults do
          delivery_method :smtp, {
            address:              settings[:smtp_server],
            port:                 settings[:smtp_port],
            user_name:            settings[:smtp_username],
            password:             settings[:smtp_password],
            enable_starttls_auto: true
          }
        end

        mail = Mail.new do
          to params[:to]
          from params[:from] || settings[:default_from]
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

      def email_settings(params)
        settings = Serializers::EmailSetting.resource(
          application_id: params[:application_id]
        )[:email_settings]

        raise "Email is not setup for this application" if settings.empty?
        return settings.first
      end
    end
  end
end
