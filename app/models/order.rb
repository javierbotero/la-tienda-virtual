class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_address, optional: true
  belongs_to :billing, optional: true
  has_many :line_items
  accepts_nested_attributes_for :line_items
  enum status: { open: 0, pending: 1, confirmed: 2, canceled: 3 }

  validate :status_update, on: :update

  private

  def status_update
    if status_changed? && status_was == 'open' && status == 'pending' &&
      (billing.nil? || shipping_address.nil?)
      errors.add(:status, "Please add billing and shipping address")
    end
  end
end
