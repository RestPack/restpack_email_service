class CreateEmailConfigurations < ActiveRecord::Migration
  def change
    create_table :restpack_email_configurations do |t|
      t.integer :application_id,        :null => false
      t.integer :domain_id
      t.string  :smtp_server,           :null => false, :limit => 1024
      t.string  :smtp_username,         :null => false, :limit => 1024
      t.string  :smtp_password,         :null => false, :limit => 1024
      t.integer :smtp_port
      t.string  :default_from,          :null => false, :limit => 512

      t.timestamps
    end
  end
end
