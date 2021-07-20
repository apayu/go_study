module CourseStore
  module V1
    class Courses < Grape::API
      helpers CourseStore::Helpers::AuthenticationHelper
      before { authenticate_user! }

      version 'v1', using: :path
      format :json
      prefix :api

      resource :courses do
        desc 'Return list of courses'
        get do
          courses = Course.all
          present courses
        end

        desc 'Return a specific course'
        route_param :id do
          get do
            course = Course.find(params[:id])
            present course, with: CourseStore::Entities::Course
          end
        end
      end
    end
  end
end
