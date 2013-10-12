require 'sidekiq'

module RestPack::Email::Service::Jobs
  module Email
    class Send
      include Sidekiq::Worker

      def perform(params)
        template = get_template(params)

        if template
          params['text_body'] = template.render_text(params['data'])
          params['html_body'] = template.render_html(params['data'])
        else
          #TODO: GJ: logging exception
        end
        Jobs::Email::SendRaw.new.perform(params)
      end

      private

      def get_template(params)
        template = Models::EmailTemplate.where(
          application_id: params['application_id'],
          identifier: params['template']
        ).take

        unless template
          #TODO: GJ: load default from disk if it exists
        end

        #TODO: GJ: inject header and footer if present in template

        template
      end
    end
  end
end
