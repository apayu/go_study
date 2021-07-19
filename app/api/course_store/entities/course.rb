module CourseStore
  module Entities
    class Course < Grape::Entity
      expose :title
      expose :price
      expose :category, merge: true, using: CourseStore::Entities::Category
      expose :currency, merge: true, using: CourseStore::Entities::Currency
      expose :status
      expose :slug
      expose :description
      expose :valid_period
    end
  end
end
