require 'spec_helper'

describe Models::Setting do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:secret) }
end
