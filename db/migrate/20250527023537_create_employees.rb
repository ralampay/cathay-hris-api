class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :mobile_number

      t.timestamps
    end
  end
end
