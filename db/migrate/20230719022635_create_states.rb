class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states, id: :uuid do |t|
      t.string :name
      t.references :city, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
