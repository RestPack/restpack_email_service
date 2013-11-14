require 'spec_helper'

describe Commands::Email::Template::Create do
  it_acts_as_create_command(:email, :template)
end
