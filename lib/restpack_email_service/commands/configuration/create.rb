module Commands::Email::Configuration
  class Create < RestPack::Service::Commands::Create
    required do
      array :configurations do
        hash do
          required do
            integer :application_id
            string :smtp_server
            string :smtp_username
            string :smtp_password
            string :default_from
          end

          optional do
            integer :domain_id
            integer :smtp_port
          end
        end
      end
    end
  end
end
