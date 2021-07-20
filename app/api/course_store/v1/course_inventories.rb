module CourseStore
  module V1
    class CourseInventories < Grape::API
      helpers CourseStore::Helpers::AuthenticationHelper
      before { authenticate_user! }

      version 'v1', using: :path
      format :json
      prefix :api

      resource :course_inventories do
        desc 'Create course inventory'
        params do
          requires :course_id, type: Integer, desc: 'course id'
        end

        post do
          course = Course.publish.find(params[:course_id])
          error!({ message: 'Duplicated bought!' }, 403) if CourseInventory.available(current_user, course).size >= 1

          BuyCourseService.new(current_user, course).perform
        rescue ActiveRecord::RecordInvalid => e
          error!({ message: e.record.errors }, 403)
        rescue ActiveRecord::RecordNotFound
          error!({ message: 'Invalid course' }, 403)
        end
      end
    end
  end
end
