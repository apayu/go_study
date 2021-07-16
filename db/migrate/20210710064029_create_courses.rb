class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.decimal :price, null: false
      t.references :currency, null: false
      t.references :category, null: false
      t.integer :status, null: false, default: 0
      t.string :slug, null: false
      t.text :description, null: false
      t.integer :valid_period, null: false

      t.timestamps
    end
  end
end
