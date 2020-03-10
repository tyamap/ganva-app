require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#password=" do
    it "文字列を与えると60文字の hashed_password を返す" do
      user =  User.new
      user.password = "password"
      expect( user.hashed_password).to be_kind_of(String)
      expect( user.hashed_password.size).to eq(60)
    end

    it "nilを与えるとnilになる" do
      user =  User.new(hashed_password: "x")
      user.password = nil
      expect( user.hashed_password).to be_nil
    end
  end
end
