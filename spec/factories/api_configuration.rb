FactoryGirl.define do
  factory :api_configuration, class: Hash do
    sequence(:application_id)

    sequence(:smtp_server)   {|n| "smtp.domain#{n}.com" }
    sequence(:smtp_username) {|n| "username_#{n}" }
    sequence(:smtp_password) {|n| "password_#{n}" }
    sequence(:default_from)  {|n| "defaultfrom@domain#{n}.com" }

    initialize_with { attributes }
  end
end

