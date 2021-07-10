# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category', type: :request do
  describe 'GET /index' do
    subject(:visit_index_page) { get categories_path }
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
    subject(:visit_new_page) { get new_category_path }
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
    subject(:create_new_category) { post categories_path, params: { category: params } }

    let(:params) { { name: 'new category name' } }
    let(:admin) { create(:admin_user) }

    context 'when user is login' do
      before { sign_in admin }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'GET /edit' do
    subject(:visit_edit_category) { get edit_category_path(category) }

    let(:category) { create(:category) }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        sign_in admin
        visit_edit_category
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'PATCH /update' do
    subject(:update_category) { patch category_path(category), params: { category: params } }

    let(:admin) { create(:admin_user) }
    let(:category) { create(:category) }
    let(:params) { { name: 'new category name' } }

    context 'when update is success' do
      before do
        sign_in admin
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context 'when update is NOT success' do
      let(:params) { { name: '' } }

      before do
        sign_in admin
      end

      it { is_expected.to render_template(:edit) }
    end
  end

  describe 'DELETE /destory' do
    subject(:delete_category) { delete category_path(category) }

    let(:admin) { create(:admin_user) }
    let(:category) { create(:category) }

    context 'when user is login' do
      before { sign_in admin }

      it { is_expected.to redirect_to(root_path) }
    end
  end
end
