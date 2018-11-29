class Subscription < ApplicationRecord
  include(Audited)

  belongs_to(:organization)
  belongs_to(:plan)
  belongs_to(:pricing)
end
