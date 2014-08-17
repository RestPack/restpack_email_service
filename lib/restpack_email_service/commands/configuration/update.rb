module Email::Commands::Configuration
  class Update < RestPack::Service::Command
    required do
      array :configurations do
        hash do
          required do
            integer :id
            integer :application_id
            string  :smtp_server
            integer :smtp_port
            string  :smtp_username
            string  :smtp_password
            string  :default_from
          end

          optional do
            integer :domain_id
          end
        end
      end
    end

    def execute
      #TODO: GJ: wrap in transaction
      #TODO: GJ: extract to base class
      result = {
        configurations: []
      }

      inputs[:configurations].each do |item|
        model = Models::Email::Configuration.find_by_id_and_application_id(
          item[:id], item[:application_id]
        )

        if model
          model.update_attributes(item)
          result[:configurations] << Serializers::Email::Configuration.as_json(model)
        else
          status :not_found
        end
      end

      result
    end
  end
end
