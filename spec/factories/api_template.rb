FactoryGirl.define do
  factory :api_template, class: Hash do
    sequence(:application_id)

    sequence(:identifier)       {|n| "template#{n}" }
    sequence(:subject_template) {|n| "This is the subject #{n}" }
    sequence(:html_template)    {|n| "This is the <b>html</b> template #{n}" }
    sequence(:text_template)    {|n| "This is the text tempalte #{n}" }

    initialize_with { attributes }
  end
end

