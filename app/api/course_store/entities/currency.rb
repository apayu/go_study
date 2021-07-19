module CourseStore
  module Entities
    class Currency < Grape::Entity
      expose :code, as: :currency
    end
  end
end
