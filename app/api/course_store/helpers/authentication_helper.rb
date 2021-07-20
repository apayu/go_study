module CourseStore
  module Helpers
    module AuthenticationHelper
      def authenticate_user!
        error!({ message: "Invalid token" }, 401) if current_user.nil?
      end

      def current_user
        @current_user ||= User.find_by(auth_token: params['auth_token'])
      end
    end
  end
end
