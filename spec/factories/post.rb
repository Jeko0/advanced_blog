FactoryBot.define do 
  factory :post do 
    title { "test" }
    body {"test body"}
    user_id {1}
    vip_only { false }
  end
end