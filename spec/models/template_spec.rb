describe Email::Models::Template do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:subject_template) }
  it { should validate_presence_of(:identifier) }
end
