module CourseStore
 class Base < Grape::API
  mount CourseStore::V1::Courses
  mount CourseStore::V1::Users
 end
end
