module Commands::Email::Configuration
  class List < RestPack::Service::Commands::List
    required do
      integer :application_id
    end

    optional do
      integer :page
      integer :page_size
    end
  end
end
