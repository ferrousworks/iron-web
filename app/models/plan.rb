class Plan < ApplicationRecord
  include(FriendlyId)
  include(Audited)

  has_many(:pricings)

  friendly_id(:name, :use => [:slugged, :history])
end
