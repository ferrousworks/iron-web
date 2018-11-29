class CreatePricings < ActiveRecord::Migration[5.2]
  def change
    create_table(:pricings, :id => :uuid) do |table|
      table.integer(:price_cents, :null => false)
      table.integer(:price_currency, :null => false)
      table.timestamps()

      table.index(:price_cents)
      table.index(:created_at)
      table.index(:updated_at)
    end
  end
end
