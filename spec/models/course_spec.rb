# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:currency_id) }
  it { is_expected.to validate_presence_of(:category_id) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:valid_period) }
  it { is_expected.to validate_inclusion_of(:valid_period).in_range(1..31) }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:course_inventories).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:users).through(:course_inventories).dependent(:restrict_with_exception) }
end
