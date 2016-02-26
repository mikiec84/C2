FactoryGirl.define do
  factory :step do
    proposal
    association :assignee, factory: :user
  end

  factory :approval_step, class: Steps::Approval do
    proposal
    association :assignee, factory: :user

    factory :serial_step, class: Steps::Serial do
    end

    factory :parallel_step, class: Steps::Parallel do
    end

    factory :purchase_step, class: Steps::Purchase do
    end
  end
end
