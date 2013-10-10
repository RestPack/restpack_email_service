class CreateEmailSetting < ActiveRecord::Migration
  def change
    create_table :restpack_email_settings do |t|
      t.integer :application_id,        :null => false
      t.string  :provider,              :null => false, :limit => 16
      t.string  :username,                              :limit => 1024
      t.string  :secret,                                :limit => 1024

      t.timestamps
    end
  end
end
