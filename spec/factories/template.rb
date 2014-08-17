FactoryGirl.define do
  factory :template, :class => Email::Models::Template do
    sequence(:application_id)
    sequence(:identifier) {|n| "template.#{n}" }
    sequence(:subject_template) {|n| "This is the subject (#{n})" }
    sequence(:text_template) {|n| "This is the text template (#{n})" }
    sequence(:html_template) {|n| "This is the <b>html</b> template (#{n})" }
  end
end
