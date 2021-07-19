module CourseStore
  module V1
    class CourseInventories < Grape::API
      before do
        @current_user = User.find_by(auth_token: params['auth_token'])
        error!({ message: "Invalid token" }, 401) if @current_user.nil?
      end

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
          error!({ message: 'Duplicated bought!' }, 401) if CourseInventory.available(@current_user, course).size >= 1

          ActiveRecord::Base.transaction do
            course_inventory = CourseInventory.new(user: @current_user, course: course, expired_at: Time.zone.now + course.valid_period.days)
            if course_inventory.save
              transaction = Transaction.new(trade_no: format("REG%d%d", @current_user.id, Time.zone.now.to_i), course_inventory: course_inventory, user: @current_user, amounts: course.price, currency_id: course.currency_id)
              if transaction.save
                { message: 'Create success!', auth_token: @current_user.auth_token, status: 200 }
              else
                error!({ message: transaction.errors }, 401)
              end
            else
              error!({ message: course_inventory.errors }, 401)
            end
          end
        rescue ActiveRecord::RecordNotFound
          error!({ message: 'Invalid course' }, 403)
        end
      end
    end
  end
end
