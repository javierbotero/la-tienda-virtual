require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_db_column(:status) }
  it { should have_db_column(:user_id) }
  it { should belong_to(:user) }
  it { should belong_to(:shipping_address).optional(true) }
  it { should belong_to(:billing).optional(true) }
  it { should have_many(:line_items) }
  it { should accept_nested_attributes_for(:line_items) }
  it do
    should define_enum_for(:status).
      with_values({ open: 0, pending: 1, confirmed: 2, canceled: 3 })
  end
end
