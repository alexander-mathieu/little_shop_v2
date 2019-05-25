FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "user_name #{n}"
    end

    sequence :address do |n|
      "#{n}234 Main St"
    end

    sequence :email do |n|
      "u#{n}@users.com"
    end

    city {"Springfield"}
    state {"VA"}
    zip {"90210"}
    password {"password"}
    role { 0 }
  end

  factory :merchant, parent: :user do
    sequence :name do |n|
      "merchant_name #{n}"
    end

    sequence :email do |n|
      "m#{n}@merchants.com"
    end

    role { 1 }
  end

  factory :admin, parent: :user do
    sequence :name do |n|
      "admin_name #{n}"
    end

    sequence :email do |n|
      "a#{n}@admins.com"
    end

    role { 2 }
  end

end
