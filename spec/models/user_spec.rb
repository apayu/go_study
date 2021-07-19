# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:course_inventories).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:courses).through(:course_inventories).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:transactions).dependent(:restrict_with_exception) }
end
