require 'spec_helper'

describe Commands::EmailTemplate::Create do
  #TODO: GJ: validate array
  # is_required :application_id, :identifier, :template

  context 'creating a template' do
    let(:response) { subject.class.run(params) }

    context 'with valid params' do
      let(:template) { {
        application_id: 123,
        identifier: 'groups:invitation',
        template: 'Please join our group',
      } }
      let(:params) { {
        templates: [template]
      } }

      it 'returns the newly created template' do
        response.success?.should == true

        templates = response.result[:templates]
        templates.length.should == 1

        templates.first[:application_id].should == 123
        templates.first[:identifier].should == 'groups:invitation'
        templates.first[:template].should == 'Please join our group'
      end
    end
  end
end
