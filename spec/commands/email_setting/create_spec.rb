require 'spec_helper'

describe Commands::EmailSetting::Create do
  it_acts_as_create_command(:email_setting)
end
