# spec/models/watch_spec.rb
require 'rails_helper'

RSpec.describe Watch, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:photo_url) }
    it { should validate_presence_of(:user_id) }

    it { should validate_length_of(:name).is_at_least(3).is_at_most(150) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(250) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "enums" do
    it { should define_enum_for(:category).with_values(standard: 0, premium: 1, premium_plus: 2) }
  end
end
