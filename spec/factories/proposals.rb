FactoryGirl.define do
  sequence(:public_id) { |n| "PUBLIC#{n}" }

  factory :proposal do
    public_id
    flow 'parallel'
    status 'pending'
    association :requester, factory: :user

    transient do
      client_slug { ENV['CLIENT_SLUG_DEFAULT'] || 'ncr' }
      delegate nil
    end

    trait :with_approver do
      after :create do |proposal, evaluator|
        proposal.approver = create(:user, client_slug: evaluator.client_slug)
      end
    end

    trait :with_serial_approvers do
      flow 'linear'
      after :create do |proposal, evaluator|
        ind = 2.times.map{ Approvals::Individual.new(user: create(:user, client_slug: evaluator.client_slug)) }
        proposal.root_approval = Approvals::Serial.new(child_approvals: ind)
      end
    end

    trait :with_parallel_approvers do
      flow 'parallel'
      after :create do |proposal, evaluator|
        ind = 2.times.map{ Approvals::Individual.new(user: create(:user, client_slug: evaluator.client_slug)) }
        proposal.root_approval = Approvals::Parallel.new(child_approvals: ind)
      end
    end

    trait :with_observer do
      after :create do |proposal, evaluator|
        observer = create(:user, client_slug: evaluator.client_slug)
        proposal.add_observer(observer.email_address)
      end
    end

    trait :with_observers do
      after :create do |proposal, evaluator|
        2.times do
          observer = create(:user, client_slug: evaluator.client_slug)
          proposal.add_observer(observer.email_address)
        end
      end
    end

    after(:create) do |proposal, evaluator|
      if evaluator.delegate
        user = create(:user, client_slug: evaluator.client_slug)
        proposal.approver = user
        user.add_delegate(evaluator.delegate)
      end
    end
  end
end
