require 'spec_helper'

describe Models::EmailTemplate do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:identifier) }
  it { should validate_presence_of(:template) }
end
