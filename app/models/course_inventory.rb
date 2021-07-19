# frozen_string_literal: true

class CourseInventory < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :not_expired, -> { where('expired_at >= ?', Time.zone.now) }
  scope :available, ->(user, course) { where(user: user, course: course).not_expired }
end
