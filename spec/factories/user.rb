FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "user_name #{n}"
    end
    sequence :address do |n|
      "#{n}234 Main St"
    end
    sequence :city do |n|
      "city #{n}"
    end
    sequence :state do |n|
      "state #{n}"
    end
    sequence :zip do |n|
      "90210"
    end
    sequence :email do |n|
      "user#{n}@users.com"
    end
    sequence :password do |n|
      "password#{n}"
    end
    role { 0 }
  end

  factory :merchant, parent: :user do
    sequence :name do |n|
      "merchant_name #{n}"
    end
    sequence :address do |n|
      "#{n}234 Main St"
    end
    sequence :city do |n|
      "city #{n}"
    end
    sequence :state do |n|
      "state #{n}"
    end
    sequence :zip do |n|
      "90210"
    end
    sequence :email do |n|
      "merchant#{n}@merchants.com"
    end
    sequence :password do |n|
      "password#{n}"
    end
    role { 1 }
  end

  factory :admin, parent: :user do
    sequence :name do |n|
      "admin_name #{n}"
    end
    sequence :address do |n|
      "#{n}234 Main St"
    end
    sequence :city do |n|
      "city #{n}"
    end
    sequence :state do |n|
      "state #{n}"
    end
    sequence :zip do |n|
      "90210"
    end
    sequence :email do |n|
      "admin#{n}@admins.com"
    end
    sequence :password do |n|
      "password#{n}"
    end
    role { 2 }
  end

end
