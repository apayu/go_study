# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Currencies', type: :request do
  describe 'GET /index' do
    subject(:visit_index_page) { get currencies_path }
    let(:admin) { create(:admin_user) }

    before do
      sign_in admin
      visit_index_page
    end

    context 'when user login' do
      it { expect(response).to have_http_status(:success) }
    end
  end
end
