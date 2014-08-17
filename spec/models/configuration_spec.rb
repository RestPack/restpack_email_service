describe Email::Models::Configuration do
  it { should validate_presence_of(:application_id) }
  it { should validate_presence_of(:smtp_server) }
  it { should validate_presence_of(:smtp_username) }
  it { should validate_presence_of(:smtp_password) }
  it { should validate_presence_of(:default_from) }
end
