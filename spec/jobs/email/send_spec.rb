require 'spec_helper'

describe Jobs::Email::Send do
  let(:expected_raw_params) { {} }
  before do
    send_raw = double('send_raw')
    send_raw.should_receive(:perform).with(expected_raw_params)
    subject.stub(:send_raw).and_return(send_raw)
    subject.stub(:template_path).and_return('../../../../../spec/templates')
  end

  context 'custom templates' do
    context 'simple template' do
      let(:template) {
        create(:template, subject_template: 'subject', text_template: 'text', html_template: 'html')
      }
      let(:expected_raw_params) { {
        application_id: template[:application_id], template: template[:identifier],
        subject: 'subject', text_body: 'text', html_body: 'html'
      } }

      it 'sends an email' do
        subject.perform({ application_id: template.application_id, template: template.identifier })
      end
    end

    context 'with a default email address' do
      let(:template) {
        create(:template, subject_template: 'subject',
          text_template: 'text', html_template: 'html', from: 'gavinjoyce@gmail.com')
      }
      let(:expected_raw_params) { {
        application_id: template[:application_id], template: template[:identifier],
        subject: 'subject', text_body: 'text', html_body: 'html', from: 'gavinjoyce@gmail.com'
      } }

      it 'sends an email' do
        subject.perform({ application_id: template.application_id, template: template.identifier })
      end
    end

  end

  context 'with a default template' do
    let(:data) { {
      inviter_name: 'Gavin', group_name: 'MyHome.ie',
      invitation: {
        id: 999
      }
    } }
    let(:expected_raw_params) { {
      application_id: 142857, template: 'group.invitation',
      subject: "Gavin has invited you to the MyHome.ie group",
      text_body: "header text\n\n\ninvitation to ID: 999\n\nfooter text",
      html_body: "<h1>header html</h1>\n\n<hr />\n\n\ninvitation to ID: 999\n\n<hr />\n\n<h2>footer html</h2>",
      data: data
    } }

    it 'sends an email' do
      subject.perform({
        application_id: 142857, template: 'group.invitation',
        data: data
      })
    end
  end
end
