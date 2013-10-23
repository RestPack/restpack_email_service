require 'spec_helper'

describe Commands::EmailTemplate::Create do
  it_acts_as_create_command(:email_template)
end
