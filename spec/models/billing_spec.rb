require 'rails_helper'

RSpec.describe Billing, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:orders) }
end
