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
          Jobs::Email::SendRaw.new.perform(params)
        else
          #TODO: GJ: logging exception
          raise "Invalid template: #{params['template']}"
        end
      end

      private

      def get_template(params)
        identifier = params['template']
        template = Models::EmailTemplate.where(
          application_id: params['application_id'],
          identifier: identifier
        ).take

        template ||= Models::EmailTemplate.new

        if template.text_template.blank?
          template.text_template = load_default_template(identifier, 'text')
        end

        if template.html_template.blank?
          template.html_template = load_default_template(identifier, 'html')
        end

        template
      end

      def load_default_template(identifier, format='html')
        template_path = '../../../../../templates'
        filepath = File.expand_path("#{template_path}/#{identifier}.#{format}.liquid", __FILE__)
        if File.exists? filepath
          return File.read(filepath)
        end
      end
    end
  end
end
