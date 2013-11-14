require 'spec_helper'

describe Models::Email::Template do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:subject_template) }
  it { should validate_presence_of(:identifier) }
end
