require 'spec_helper'

describe Commands::EmailSetting::Create do
  #TODO: GJ: validate array
  # is_required :application_id, :provider, :username, :secret

  context 'creating a setting' do
    let(:response) { subject.class.run(params) }

    context 'with valid params' do
      let(:setting) { {
        application_id: 123,
        provider: 'aws_ses',
        username: 'user123',
        secret:   'supersecret'
      } }
      let(:params) { {
        settings: [setting]
      } }

      it 'returns the newly created setting' do
        response.success?.should == true

        settings = response.result[:settings]
        settings.length.should == 1

        settings.first[:application_id].should == 123
        settings.first[:provider].should == 'aws_ses'
        settings.first[:username].should == 'user123'
        settings.first[:secret].should == 'supersecret'
      end
    end
  end
end
