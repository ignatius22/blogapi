require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {create(:user)}

  it 'decreases the count of posts by 1' do
    create(:post, user: user)

    expect {
      user.destroy
    }.to change(Post, :count).by(-1)
  end

  it 'should have a title' do
    post = build(:post, title:nil)
    expect(post).not_to be_valid
  end
end
