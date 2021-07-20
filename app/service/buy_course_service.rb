# frozen_string_literal: true

class BuyCourseService

  attr_reader :user, :course, :course_inventory

  def initialize(user, course)
    @user = user
    @course = course
  end

  def perform
    ActiveRecord::Base.transaction do
      save_course_inventory!
      save_transaction!

      { message: 'Create success!', auth_token: user.auth_token, status: 200 }
    end
  end

  private

  def save_course_inventory!
    @course_inventory = CourseInventory.new(user: user, course: course, expired_at: expired_at)
    course_inventory.save!
  end

  def save_transaction!
    transaction = Transaction.new(trade_no: trade_no, course_inventory: course_inventory, user: user, amounts: course.price, currency_id: course.currency_id)
    transaction.save!
  end

  def expired_at
    Time.zone.now + course.valid_period.days
  end

  def trade_no
    format("REG%d%d", user.id, Time.zone.now.to_i)
  end
end
