class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table(:plans, :id => :uuid) do |table|
      table.text(:name, :null => false)
      table.text(:slug, :null => false)
      table.text(:description, :null => false)
      table.timestamps()

      table.index(:slug, :unique => true)
      table.index(:created_at)
      table.index(:updated_at)
    end
  end
end
