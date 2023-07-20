class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :seller, null: false, foreign_key: true, type: :uuid
      t.references :customer, null: false, foreign_key: true, type: :uuid
      t.references :city, null: false, foreign_key: true, type: :uuid
      t.references :state, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
