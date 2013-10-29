module RestPack::Email::Service::Commands
  module EmailTemplate
    class Update < RestPack::Service::Command
      required do
        array :email_templates do
          hash do
            required do
              integer :id
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
        #TODO: GJ: wrap in transaction
        result = {
          email_templates: []
        }

        inputs[:email_templates].each do |email_template_inputs|
          email_template = Models::EmailTemplate.find_by_id_and_application_id(
            email_template_inputs[:id], email_template_inputs[:application_id]
          )

          if email_template
            email_template.update_attributes(email_template_inputs)
            result[:email_templates] << Serializers::EmailTemplate.as_json(email_template)
          else
            status :not_found
          end
        end

        return result
      end
    end
  end
end
