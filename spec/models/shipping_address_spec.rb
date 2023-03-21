require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  it { should have_many :orders }
  it { should belong_to :user }
end
