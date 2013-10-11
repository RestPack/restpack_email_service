module RestPack::Email::Service::Commands
  module Email
    class Send < RestPack::Service::Command
      required do
        integer :application_id
        string :from #TODO: GJ: add email validation
        string :to
        string :subject
        string :text_body
      end

      optional do
        string :cc
        string :bcc
        string :reply_to
        string :html_body
      end

      def execute
        #TODO: GJ: decide on response format for jobs
        {
          job_id: Jobs::Email::Send.perform_async(inputs)
        }
      end
    end
  end
end
