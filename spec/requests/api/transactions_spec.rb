# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Transaction', type: :request do
  describe 'POST /create' do
    subject(:get_transaction_list) { get '/api/v1/transactions', params: params }

    let(:course) { create(:course) }
    let(:transaction) { Transaction.find_by(user: user) }
    let(:user) { create(:user) }
    let(:auth_token) { user.auth_token }
    let(:params) do
      {
        auth_token: auth_token
      }
    end

    let(:response_body) do
      {
        trade_no: transaction.trade_no
      }.to_json
    end

    context 'When query is success' do
      before do
        post "/api/v1/course_inventories?auth_token=#{auth_token}", params: { course_id: course.id }
        get_transaction_list
      end

      it { expect(response.body).to include(transaction.trade_no) }
      it { expect(response.body).to include(course.title) }
      it { expect(response.body).to include(course.price.to_f.to_s) }
      it { expect(response.body).to include(course.category.name) }
      it { expect(response.body).to include(course.currency.code) }
      it { expect(response.body).to include(course.status) }
      it { expect(response.body).to include(course.slug) }
      it { expect(response.body).to include(course.description) }
      it { expect(response.body).to include(course.valid_period.to_s) }
      it { expect(response.body).to include(course.valid_period.to_s) }
      it { expect(response).to have_http_status(:success) }
    end
  end
end
