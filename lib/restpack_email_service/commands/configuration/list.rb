module Email::Commands::Configuration
  class List < RestPack::Service::Commands::List
    required do
      integer :application_id
    end
  end
end
