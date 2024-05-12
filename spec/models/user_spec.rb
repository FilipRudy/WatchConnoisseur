# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
  end

  describe "associations" do
    it { should have_many(:watches) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  end
end
