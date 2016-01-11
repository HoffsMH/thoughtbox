require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(email: "joe@example.com", password: "pass")
  end

  it "is valid" do
    expect(user).to be_valid
  end

  it "is invalid with out an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is invalid with out unique email" do
    user.save
    user2 = User.create(email: "joe@example.com", password: "pass")
    expect(user2).not_to be_valid
  end

end
