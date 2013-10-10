module RestPack::Email::Service::Commands
  module EmailSetting
    class Create < RestPack::Service::Command
      required do
        array :settings do
          hash do
            required do
              integer :application_id
              string :provider, in: ['aws_ses']
              string :username
              string :secret
            end
          end
        end
      end

      def execute
        settings = Models::EmailSetting.create!(inputs[:settings])
        Serializers::EmailSetting.serialize(settings)
      end
    end
  end
end
