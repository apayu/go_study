module CourseStore
 class Base < Grape::API
  mount CourseStore::V1::Courses
 end
end
