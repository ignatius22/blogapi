require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {build(:user)}

  it 'user with a valid email should be valid' do
    user.email = 'test@test.org'
    expect(user).to be_valid
  end

  it 'user with invalid email should be invalid' do
    user.email = "test"
    expect(user).not_to be_valid
  end
  
  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is not valid without email attributes" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is not valid without password attributes" do
    user.password_digest = nil
    expect(user).not_to be_valid
  end

  it "is not valid without fullname attributes" do
    user.fullname = nil
    expect(user).not_to be_valid
  end

  it "is not valid with a taken email" do
    # Create a user with an email that already exists in the database
    existing_user = create(:user)
    user.email = existing_user.email
    expect(user).not_to be_valid
  end
  
end
