FactoryBot.define do
    factory :employee do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        gender { ["F", "M"].sample }
        mobile_number { "9#{Array.new(9) { rand(10) }.join('')}" }
    end
end