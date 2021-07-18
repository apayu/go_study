# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe 'GET /index' do
    subject(:visit_index_page) { get courses_path }
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
    subject(:visit_new_page) { get new_course_path }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      context 'when currency is NOT exist' do
        before do
          create(:category)
          sign_in admin
          visit_new_page
        end

        it { is_expected.to redirect_to new_currency_path }
      end

      context 'when category is NOT exist' do
        before do
          create(:currency)
          sign_in admin
          visit_new_page
        end

        it { is_expected.to redirect_to new_category_path }
      end
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to new_admin_user_session_path }
    end
  end

  describe 'POST /create' do
    subject(:create_new_course) { post courses_path, params: { course: params } }

    let(:params) do
      {
        title: 'new course name',
        price: 1000,
        currency_id: currency.id,
        category_id: category.id,
        status: 'publish',
        slug: 'test',
        description: 'test description',
        valid_period: 30
      }
    end
    let(:category) { create(:category) }
    let(:currency) { create(:currency) }
    let(:admin) { create(:admin_user) }

    context 'when create success' do
      before { sign_in admin }

      it { is_expected.to redirect_to(courses_path) }
    end

    context 'when create is NOT success' do
      let(:params) do
        {
          title: '',
          price: 1000,
          currency_id: currency.id,
          category_id: category.id,
          status: 'publish',
          slug: 'test',
          description: 'test description',
          valid_period: 30
        }
      end

      before { sign_in admin }

      it { is_expected.to render_template(:new) }
    end
  end

  describe 'GET /edit' do
    subject(:visit_edit_course) { get edit_course_path(course) }

    let(:course) { create(:course) }
    let(:admin) { create(:admin_user) }

    context 'when user login' do
      before do
        create(:category, name: 'my category')
        sign_in admin
        visit_edit_course
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'when user is NOT login' do
      it { is_expected.to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'PATCH /update' do
    subject(:update_course) { patch course_path(course), params: { course: params } }

    let(:params) do
      {
        title: 'new course name',
        price: 1000,
        currency_id: course.currency_id,
        category_id: course.category_id,
        status: 'publish',
        slug: 'test',
        description: 'test description',
        valid_period: 30
      }
    end
    let(:course) { create(:course) }
    let(:admin) { create(:admin_user) }

    context 'when edit success' do
      before { sign_in admin }

      it { is_expected.to redirect_to(courses_path) }
    end

    context 'when edit is NOT success' do
      let(:params) do
        {
          title: ''
        }
      end

      before { sign_in admin }

      it { is_expected.to render_template(:edit) }
    end
  end

  describe 'DELETE /destory' do
    subject(:delete_course) { delete course_path(course) }

    let(:admin) { create(:admin_user) }
    let(:course) { create(:course) }

    context 'when user is login' do
      before { sign_in admin }

      it { is_expected.to redirect_to(root_path) }
      it do
        course
        expect { delete_course }.to change(Course, :count).by(-1)
      end
    end
  end
end
