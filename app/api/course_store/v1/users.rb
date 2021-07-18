module CourseStore
  module V1
    class Users < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :users do
        desc 'Create user'
        params do
          requires :email, type: String, desc: 'email'
          requires :password, type: String, desc: 'password'
        end

        desc 'Return a specific course'
        post do
          user = User.new(email: params[:email], password: params[:password])
          if user.save
            { message: 'Create success!', auth_token: user.auth_token, status: 200 }
          else
            error!({ message: user.errors }, 401)
          end
        end
      end

      namespace 'login' do
        desc 'User login'
        params do
          requires :email, type: String, desc: 'email'
          requires :password, type: String, desc: 'password'
        end

        post do
          user = User.find_by(email: params[:email])
          if user.present? && user.valid_password?(params[:password])
            { message: 'login!', auth_token: user.auth_token, status: 200 }
          else
            error!({ message: "Invalid email or password" }, 401)
          end
        end
      end

      namespace 'logout' do
        desc 'User logout'
        params do
          requires :auth_token, type: String, desc: 'auth_token'
        end

        post do
          user = User.find_by(auth_token: params['auth_token'])
          if user.nil?
            error!({ message: "Invalid token" }, 401)
          else
            user.regenerate_auth_token
            { message: 'logout!', status: 200 }
          end
        end
      end
    end
  end
end
