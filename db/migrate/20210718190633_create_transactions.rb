# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :trade_no
      t.references :course_inventory, null: false
      t.references :user, null: false
      t.decimal :amounts, null: false
      t.references :currency, null: false
      t.timestamps
    end
  end
end
