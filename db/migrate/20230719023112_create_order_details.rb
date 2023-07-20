class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details, id: :uuid do |t|
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.decimal :unit_cost, precision: 12, scale: 2
      t.integer :quantity
      t.decimal :total_cost, precision: 12, scale: 2
      t.decimal :total_seller_price, precision: 12, scale: 2

      t.timestamps
    end
  end
end
