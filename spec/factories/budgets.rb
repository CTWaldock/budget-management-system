FactoryGirl.define do
  factory :budget do
    limit 10000.00
    name "My Budget"
    start_date Date.current
    end_date Date.current + 30
    total_expense 0.00
  end
end
