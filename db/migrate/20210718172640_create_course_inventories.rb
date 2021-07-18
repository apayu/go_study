# frozen_string_literal: true

class CreateCourseInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :course_inventories do |t|
      t.references :user, null: false
      t.references :course, null: false
      t.datetime :expired_at
      t.timestamps
    end
  end
end
