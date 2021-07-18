# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :category
  belongs_to :currency
  has_many :course_inventories, dependent: :restrict_with_exception
  has_many :users, through: :course_inventories, dependent: :restrict_with_exception

  validates :title, presence: true
  validates :price, presence: true
  validates :currency_id, presence: true
  validates :category_id, presence: true
  validates :status, presence: true
  validates :slug, presence: true
  validates :description, presence: true
  validates :valid_period, presence: true

  enum status: { unpublish: 0, publish: 1 }
end
