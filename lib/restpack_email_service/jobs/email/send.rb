require 'sidekiq'

module Jobs::Email
  class Send
    include Sidekiq::Worker

    def perform(params)
      params.deep_symbolize_keys!

      template = get_template(params)

      if template
        params[:subject] = template.render_subject(params[:data])
        params[:text_body] = template.render_text(params[:data])
        params[:html_body] = template.render_html(params[:data])

        if template.from
          params[:from] ||= template.from
        end

        send_raw.perform(params)
      else
        #TODO: GJ: logging exception
        raise "Invalid template: #{params['template']}"
      end
    end

    private

    def send_raw
      Jobs::Email::SendRaw.new
    end

    def get_template(params)
      application_id = params[:application_id]
      template = resolve_template(application_id, params[:template])
      inject_header_and_footer(template, application_id)

      template
    end

    def resolve_template(application_id, identifier)
      template = Models::Email::Template.where(
        application_id: application_id,
        identifier: identifier
      ).take

      template ||= Models::Email::Template.new

      if template.subject_template.blank?
        template.subject_template = load_default_template(identifier, 'subject')
      end

      if template.text_template.blank?
        template.text_template = load_default_template(identifier, 'text')
      end

      if template.html_template.blank?
        template.html_template = load_default_template(identifier, 'html')
      end

      template
    end

    def load_default_template(identifier, format='html')
      filepath = File.expand_path("#{template_path}/#{identifier}.#{format}.liquid", __FILE__)
      if File.exists? filepath
        return File.read(filepath)
      end
    end

    def template_path
      '../../../../../templates'
    end

    def inject_header_and_footer(template, application_id)
      if template
        header = resolve_template(application_id, '_header')
        footer = resolve_template(application_id, '_footer')

        if template.html_template
          template.html_template = template.html_template.gsub('{{header}}', header.html_template)
          template.html_template = template.html_template.gsub('{{footer}}', footer.html_template)
        end

        if template.text_template
          template.text_template = template.text_template.gsub('{{header}}', header.text_template)
          template.text_template = template.text_template.gsub('{{footer}}', footer.text_template)
        end
      end
    end
  end
end
