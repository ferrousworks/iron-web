class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table(:subscriptions, :id => :uuid) do |table|
      table.integer(:cost_cents, :null => false)
      table.text(:cost_currency, :null => false)
      table.uuid(:pricing_id, :null => false)
      table.uuid(:organization_id, :null => false)
      table.uuid(:plan_id, :null => false)
      table.timestamps()

      table.index(:slug, :unique => true)
      table.index(:pricing_id)
      table.index(:organization_id)
      table.index(:plan_id)
      table.index(:created_at)
      table.index(:updated_at)

      table.foreign_key(:pricings, :column => :pricing_id)
      table.foreign_key(:organizations, :column => :organization_id)
      table.foreign_key(:plans, :column => :plan_id)
    end
  end
end
