class CreateEmailTemplate < ActiveRecord::Migration
  def change
    create_table :restpack_email_templates do |t|
      t.integer :application_id,        :null => false
      t.string  :identifier,            :null => false, :limit => 256
      t.string  :text_template,                         :limit => 65536
      t.string  :html_template,                         :limit => 65536

      t.timestamps
    end
  end
end
