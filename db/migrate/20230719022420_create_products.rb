class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :code
      t.decimal :cost, precision: 12, scale: 2

      t.timestamps
    end
  end
end
