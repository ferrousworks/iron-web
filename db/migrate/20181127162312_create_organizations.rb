class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table(:organizations, :id => :uuid) do |table|
      table.text(:name, :null => false)
      table.text(:slug, :null => false)
      table.uuid(:owmer_id, :null => false)
      table.timestamps()

      table.index(:slug, :unique => true)
      table.index(:owner_id)
      table.index(:created_at)
      table.index(:updated_at)

      table.foreign_key(:accounts, :column => :owner_id)
    end
  end
end
