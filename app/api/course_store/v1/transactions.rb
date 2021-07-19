module CourseStore
  module V1
    class Transactions < Grape::API
      before do
        @current_user = User.find_by(auth_token: params['auth_token'])
        error!({ message: "Invalid token" }, 401) if @current_user.nil?
      end

      version 'v1', using: :path
      format :json
      prefix :api

      resource :transactions do
        desc 'Return list of transactions'
        get do
          # course_inventories = @current_user.course_inventories
          present @current_user, with: CourseStore::Entities::User
        end
      end
    end
  end
end
