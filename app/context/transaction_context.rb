# frozen_string_literal: true

class TransactionContext
  attr_reader :category_id, :valid_course, :query

  def initialize(params, current_user)
    @category_id = params[:category_id]
    @valid_course = params[:valid_course]
    @query = current_user.transactions
  end

  def perform
    filter_by_category_id
    filter_by_valid_course
    query
  end

  private

  def filter_by_category_id
    @query = query.joins(course_inventory: :course).where("courses.category_id = ?", category_id) if category_id.present?
  end

  def filter_by_valid_course
    @query = query.where("course_inventories.expired_at >= ?", Time.zone.now) if valid_course
  end
end

