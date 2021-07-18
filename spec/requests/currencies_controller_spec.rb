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

  describe 'GET /edit' do
    subject(:visit_edit_currency) { get edit_currency_path(currency) }

    let(:currency) { create(:currency) }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        sign_in admin
        visit_edit_currency
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'GET /edit' do
    subject(:visit_edit_currency) { get edit_currency_path(currency) }

    let(:currency) { create(:currency) }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        sign_in admin
        visit_edit_currency
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'PATCH /update' do
    subject(:update_currency) { patch currency_path(currency), params: { currency: params } }

    let(:admin) { create(:admin_user) }
    let(:currency) { create(:currency) }
    let(:params) { { code: 'JPY' } }

    context 'when update is success' do
      before do
        sign_in admin
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context 'when update is NOT success' do
      let(:params) { { code: '' } }

      before do
        sign_in admin
      end

      it { is_expected.to render_template(:edit) }
    end
  end

  describe 'DELETE /destory' do
    subject(:delete_currency) { delete currency_path(currency) }

    let(:admin) { create(:admin_user) }
    let(:currency) { create(:currency) }

    context 'when user is login' do
      before { sign_in admin }

      it { is_expected.to redirect_to(root_path) }
      it do
        currency
        expect { delete_currency }.to change(Currency, :count).by(-1)
      end
    end
  end
end
