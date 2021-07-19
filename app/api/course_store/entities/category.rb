module CourseStore
  module Entities
    class Category < Grape::Entity
      expose :name, as: :category
    end
  end
end
