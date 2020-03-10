require 'rails_helper'

RSpec.describe User, type: :model 

describe '#valid=' do
  before do
    @user = User.new(
      email: 'test@example.com', 
      password: 'password', 
      name: 'テスト', 
      uid: 'test_admin'
    ) 
  end

  example '有効ならtrueを返す' do
    expect(@user.valid?).to be_truthy
  end

  example '名前が空白ならfalseを返す' do
    @user.name = ''
    expect(@user.valid?).to be_falsey
  end

  example '名前が50文字以下ならtrueを返す' do
    @user.name = 'a' *50
    expect(@user.valid?).to be_truthy
  end

  example '名前が51文字以上ならfalseを返す' do
    @user.name = 'a' * 51
    expect(@user.valid?).to be_falsey
  end

  example 'Emailが255文字以下ならtrueを返す' do
    @user.email = 'a' * 243 + '@example.com'
    expect(@user.valid?).to be_truthy
  end

  example 'Emailが256文字以上ならfalseを返す' do
    @user.email = 'a' * 244 + '@example.com'
    expect(@user.valid?).to be_falsey
  end
end

describe '#password=' do
  example '文字列を与えると60文字の hashed_password を返す' do
    user = User.new
    user.password = 'password'
    expect(user.hashed_password).to be_kind_of(String)
    expect(user.hashed_password.size).to eq(60)
  end

  example 'nilを与えるとnilになる' do
    user = User.new(hashed_password: 'x')
    user.password = nil
    expect(user.hashed_password).to be_nil
  end
end
