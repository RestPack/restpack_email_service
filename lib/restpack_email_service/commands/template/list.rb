module Email::Commands::Template
  class List < RestPack::Service::Commands::List
    required do
      integer :application_id
    end

    optional do
      integer :domain_id
      integer :page
      integer :page_size
    end
  end
end
