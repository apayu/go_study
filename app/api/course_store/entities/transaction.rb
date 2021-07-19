module CourseStore
  module Entities
    class Transaction < Grape::Entity
      expose :trade_no
      expose :course_inventory, using: CourseStore::Entities::CourseInventory
    end
  end
end
