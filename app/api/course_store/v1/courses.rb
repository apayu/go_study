module CourseStore
  module V1
    class Courses < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :courses do
        desc 'Return list of courses'
        get do
          courses = Course.all
          present courses
        end
      end
    end
  end
end
