module CourseStore
  module Entities
    class User < Grape::Entity
      expose :transactions, using: CourseStore::Entities::Transaction
    end
  end
end
