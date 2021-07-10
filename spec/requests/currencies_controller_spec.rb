# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Currencies', type: :request do
  describe 'GET /index' do
    subject(:visit_index_page) { get currencies_path }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        sign_in admin
        visit_index_page
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'GET /new' do
    subject(:visit_new_page) { get new_currency_path }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        sign_in admin
        visit_new_page
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'POST /create' do
    subject(:create_new_currency) { post currencies_path, params: { currency: params } }

    let(:params) { { code: 'NTD' } }
    let(:admin) { create(:admin_user) }

    context 'when user is login' do
      before { sign_in admin }

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
