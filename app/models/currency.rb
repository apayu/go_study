# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :code, presence: true, uniqueness: true
end
