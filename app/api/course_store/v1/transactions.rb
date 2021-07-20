module CourseStore
  module V1
    class Transactions < Grape::API
      helpers CourseStore::Helpers::AuthenticationHelper
      before { authenticate_user! }

      version 'v1', using: :path
      format :json
      prefix :api

      resource :transactions do
        desc 'Return list of transactions'
        params do
          optional :valid_course, type: Boolean
          optional :category_id, type: Integer
        end
        get do
          transactoins = TransactionContext.new(params, current_user).perform
          present transactoins, with: CourseStore::Entities::Transaction
        end
      end
    end
  end
end
