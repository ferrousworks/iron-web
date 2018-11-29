class Pricing < ApplicationRecord
  include(Audited)

  belongs_to(:plans)
  has_many(:subscriptions)
end
