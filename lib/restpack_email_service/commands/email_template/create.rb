module RestPack::Email::Service::Commands
  module EmailTemplate
    class Create < RestPack::Service::Command
      required do
        array :templates do
          hash do
            required do
              integer :application_id
              string :identifier
            end

            optional do
              string :text_template
              string :html_template
            end
          end
        end
      end

      def execute
        templates = Models::EmailTemplate.create!(inputs[:templates])
        Serializers::EmailTemplate.serialize(templates)
      end
    end
  end
end
