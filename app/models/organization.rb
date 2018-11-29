class Organization < ApplicationRecord
  include(FriendlyId)
  include(Audited)

  has_many(:accounts)
  belongs_to(:owner, :class_name => "Account")

  friendly_id(:name, :use => [:slugged, :history])
end
