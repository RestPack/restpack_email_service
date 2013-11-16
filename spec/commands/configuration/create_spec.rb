require 'spec_helper'

describe Commands::Email::Configuration::Create do
  it_acts_as_single_create_command(:email, :configuration)
end
