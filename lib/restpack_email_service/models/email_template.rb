require 'liquid'

module RestPack::Email::Service::Models
  class EmailTemplate < ActiveRecord::Base
    self.table_name = :restpack_email_templates

    attr_accessible :application_id, :identifier, :from, :subject_template,
                    :text_template, :html_template, :test_data
    validates_presence_of :application_id, :identifier, :subject_template,
                          :text_template, :html_template

    def render_subject(data)
      render(subject_template, data)
    end
    def render_text(data)
      render(text_template, data)
    end
    def render_html(data)
      render(html_template, data)
    end

    private

    def render(template, data)
      return nil unless template

      data.deep_stringify_keys! if data
      rendered = Liquid::Template.parse(template).render(data)
      rendered.strip
    end
  end
end
