require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_db_column(:status) }
  it { should have_db_column(:user_id) }
  it { should belong_to(:user) }
  it { should have_many(:line_items) }
end
