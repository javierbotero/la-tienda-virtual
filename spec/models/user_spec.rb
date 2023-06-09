require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column(:username) }
  it { should have_db_column(:email) }
  it { should have_many(:orders) }
end
