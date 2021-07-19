module CourseStore
 class Base < Grape::API
  mount CourseStore::V1::Courses
  mount CourseStore::V1::Users
  mount CourseStore::V1::CourseInventories
  mount CourseStore::V1::Transactions
 end
end
