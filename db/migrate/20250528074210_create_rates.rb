class CreateRates < ActiveRecord::Migration[8.0]
  def change
    create_table :rates do |t|
      t.references :employee, null: false, foreign_key: true
      t.decimal :amount
      t.date :date_effect

      t.timestamps
    end
  end
end
