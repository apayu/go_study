# frozen_string_literal: true

class CourseInventory < ApplicationRecord
  belongs_to :user
  belongs_to :course
end
