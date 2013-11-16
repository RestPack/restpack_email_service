module Commands::Email::Template
  class Create < RestPack::Service::Commands::SingleCreate
    required do
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
