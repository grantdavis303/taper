class CreateDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :drinks do |t|
      t.references :account, null: false, foreign_key: true
      t.string :drink_type
      t.decimal :ounces
      t.decimal :percentage

      t.timestamps
    end
  end
end
