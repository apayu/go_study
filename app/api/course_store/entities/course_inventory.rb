module CourseStore
  module Entities
    class CourseInventory < Grape::Entity
      expose :course, using: CourseStore::Entities::Course
      expose :expired_at
    end
  end
end
