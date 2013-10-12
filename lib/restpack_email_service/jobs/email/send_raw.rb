require 'sidekiq'
require 'mail'

module RestPack::Email::Service::Jobs
  module Email
    class SendRaw
      include Sidekiq::Worker

      def perform(params)
        settings = email_settings(params)

        #TODO: GJ: add support for providers other than AWS SES
        Mail.defaults do
          delivery_method :smtp, {
            :address              => 'email-smtp.us-east-1.amazonaws.com',
            :port                 => 587,
            :user_name            => settings[:username],
            :password             => settings[:secret],
            :enable_starttls_auto => true
          }
        end

        mail = Mail.new do
          to params['to']
          from params['from']
          subject params['subject']

          text_part do
            body params['text_body']
          end

          if params['html_body']
            html_part do
              content_type 'text/html; charset=UTF-8'
              body params['html_body']
            end
          end
        end

        mail.deliver
      end

      private

      def email_settings(params) #TODO: GJ: use models to fetch the relevant email settings
        settings = Serializers::EmailSetting.resource(
          application_id: params['application_id']
        )[:settings].first

        raise "Email is not setup for this application" unless settings
        raise "Only the Amazon SES provider is supported" unless settings[:provider] == 'aws_ses'
        return settings
      end
    end
  end
end
