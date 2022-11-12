class AddColumnsToPersos < ActiveRecord::Migration[5.2]
  def change
    add_column :persos, :name, :string
    add_column :persos, :side, :string
    add_column :persos, :health, :string
    add_column :persos, :captured, :boolean
    add_column :persos, :diplomatie, :integer
    add_column :persos, :charisme, :integer
    add_column :persos, :discretion, :integer
    add_column :persos, :fight, :integer
    add_column :persos, :recrutement, :boolean
    add_column :persos, :trainer, :boolean
    add_column :persos, :innovation, :boolean
    add_column :persos, :moving, :boolean
    add_column :persos, :mission, :boolean
    add_column :persos, :zone, :string
  end
end
