module RestPack::Email::Service::Commands
  module EmailTemplate
    class Create < RestPack::Service::Command
      required do
        array :email_templates do
          hash do
            required do
              integer :application_id
              string :identifier
              string :subject_template
            end

            optional do
              integer :domain_id
              string :from
              string :text_template
              string :html_template
              string :data #TODO: GJ: json type?
            end
          end
        end
      end

      def execute
        templates = Models::EmailTemplate.create!(inputs[:email_templates])
        Serializers::EmailTemplate.serialize(templates)
      end
    end
  end
end
