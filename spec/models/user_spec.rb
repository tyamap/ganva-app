require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe "Normalization" do
    it "Emailの前後の空白を除去する" do
      user = create(:user, email: " test@example.com")
      expect(user.email).to eq("test@example.com")
    end

    it "Emailの全角文字は半角文字に変換する" do
      user = create(:user, email: "ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ")
      expect(user.email).to eq("test@example.com")
    end

    it "Emailの前後の全角空白を除去する" do
      user = create(:user, email: "\u{3000}test@example.com\u{3000}")
      expect(user.email).to eq("test@example.com")
    end
  end

  describe "validation" do
    it "Emailに連続＠を含むものはNG" do
      user = build(:user, email: "test@@example.com")
      expect(user).not_to be_valid
    end
    
    it "アルファベットを含む名前はOK" do
      user = build(:user, name: "Smith")
      expect(user).to be_valid
    end
    
    it "記号を含む名前はOK" do
      user = build(:user, name: "試験★")
      expect(user).to be_valid
    end
    
    it "重複したEmailはNG" do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).not_to be_valid
    end
  end
end
  