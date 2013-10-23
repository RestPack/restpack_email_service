module RestPack::Email::Service::Models
  class EmailSetting < ActiveRecord::Base
    self.table_name = :restpack_email_settings

    attr_accessible :application_id, :domain_id, :smtp_server, :smtp_username,
                    :smtp_password, :smtp_port, :default_from
    validates_presence_of :application_id, :smtp_server, :smtp_username,
                          :smtp_password, :default_from
  end
end
