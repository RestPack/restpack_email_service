module RestPack::Email::Service::Models
  class Setting < ActiveRecord::Base
    self.table_name = :restpack_email_settings

    attr_accessible :application_id, :provider, :username, :secret
    validates_presence_of :application_id, :provider, :username, :secret
  end
end
