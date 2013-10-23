require 'liquid'

module RestPack::Email::Service::Models
  class EmailTemplate < ActiveRecord::Base
    self.table_name = :restpack_email_templates

    attr_accessible :application_id, :identifier, :from, :subject_template,
                    :text_template, :html_template
    validates_presence_of :application_id, :identifier, :subject_template,
                          :text_template, :html_template

    def render_subject(data)
      if self.text_template
        return Liquid::Template.parse(self.subject_template).render(data)
      end
    end
    def render_text(data)
      if self.text_template
        return Liquid::Template.parse(self.text_template).render(data)
      end
    end
    def render_html(data)
      if self.html_template
        return Liquid::Template.parse(self.html_template).render(data)
      end
    end
  end
end
