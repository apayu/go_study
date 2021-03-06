# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currency, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
end
