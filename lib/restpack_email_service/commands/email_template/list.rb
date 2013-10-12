module RestPack::Email::Service::Commands
  module EmailTemplate
    class List < RestPack::Service::Command
      required do
        integer :application_id
      end

      optional do
        integer :page
        integer :page_size
      end

      def execute
        Serializers::EmailTemplate.resource(inputs)
      end
    end
  end
end
