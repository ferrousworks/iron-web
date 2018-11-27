class Payment < ApplicationRecord
  # NOTE: Ordered by preference
  TYPES = [
    "GiftCardPayment",
    "CreditPayment",
    "StripePayment"
  ].freeze
  include(AuditedWithTransitions)

  belongs_to(:account)
  belongs_to(:cart)

  monetize(:paid_cents)
  monetize(:restitution_cents, :allow_nil => true)

  validates_presence_of(:subtype)
  validates_inclusion_of(:subtype, :in => TYPES)
  validates_presence_of(:source_id)
  validates_presence_of(:processing_state)
  validates_inclusion_of(:processing_state, :in => ["pending", "paid", "refunded"])

  state_machine(:processing_state, :initial => :pending) do
    event(:charge) do
      transition(:from => :pending, :to => :paid)
    end

    event(:refund) do
      transition(:from => :paid, :to => :refunded)
    end

    before_transition(:do => :version_transition)
  end

  def preference
    TYPES.index(subtype)
  end
end
