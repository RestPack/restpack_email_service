module Email::Commands::Template
  class Create < RestPack::Service::Commands::Create
    required do
      array :templates do
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
            model :data, class: Hash
          end
        end
      end
    end
  end
end
