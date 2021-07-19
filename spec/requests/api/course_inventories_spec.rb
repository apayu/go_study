# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::CourseInventory', type: :request do
  describe 'POST /create' do
    subject(:create_new_course_inventory) { post "/api/v1/course_inventories?auth_token=#{auth_token}", params: params }

    let(:user) { create(:user) }
    let(:auth_token) { user.auth_token }
    let(:course) { create(:course) }
    let(:params) do
      { course_id: course.id }
    end

    context 'When course is publish' do
      let(:response_body) do
        {
          message: 'Create success!',
          auth_token: user.auth_token,
          status: 200
        }.to_json
      end

      before { create_new_course_inventory }

      it { expect(response.body).to eq(response_body) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'When auth_token is invalid' do
      let(:auth_token) { '1234' }
      let(:response_body) do
        {
          message: 'Invalid token',
        }.to_json
      end

      before { create_new_course_inventory }

      it { expect(response.body).to eq(response_body) }
      it { expect(response).to have_http_status(401) }
    end

    context 'When course is NOT publish' do
      let(:unpublish_course) { create(:course, status: 'unpublish') }
      let(:params) do
        { course_id: unpublish_course.id }
      end

      let(:response_body) do
        {
          message: 'Invalid course',
        }.to_json
      end

      before { create_new_course_inventory }

      it { expect(response.body).to eq(response_body) }
      it { expect(response).to have_http_status(403) }
    end

    context 'when course is duplicated bought' do
      let!(:course_inventory) { create(:course_inventory, course: course, user: user, expired_at: Time.zone.now + 1.days) }
      let(:params) do
        { course_id: course.id }
      end

      let(:response_body) do
        {
          message: 'Duplicated bought!',
        }.to_json
      end

      before do
        create_new_course_inventory
      end

      it { expect(response.body).to eq(response_body) }
      it { expect(response).to have_http_status(403) }
    end
  end
end
