module RestPack::Email::Service::Commands
  module EmailSetting
    class List < RestPack::Service::Command
      required do
        integer :application_id
      end

      optional do
        integer :page
        integer :page_size
      end

      def execute
        Serializers::EmailSetting.resource(inputs)
      end
    end
  end
end
