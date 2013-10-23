module RestPack::Email::Service::Commands
  module EmailSetting
    class Create < RestPack::Service::Command
      required do
        array :email_settings do
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

      def execute
        email_settings = Models::EmailSetting.create!(inputs[:email_settings])
        Serializers::EmailSetting.serialize(email_settings)
      end
    end
  end
end
