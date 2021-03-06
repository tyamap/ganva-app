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
  
  describe '#password' do
    example '文字列を与えると60文字の password_digest を返す' do
      user = create(:user, password: "password")
      expect(user.password_digest).to be_kind_of(String)
      expect(user.password_digest.size).to eq(60)
    end
    
    example 'nilを与えるとnilになる' do
      user = create(:user, password: "password")
      user.password = nil
      expect(user.password_digest).to be_nil
    end
  end

  describe "#normalization" do
    example "Emailの前後の空白を除去する" do
      user = create(:user, email: " test@example.com")
      expect(user.email).to eq("test@example.com")
    end

    example "Emailの全角文字は半角文字に変換する" do
      user = create(:user, email: "ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ")
      expect(user.email).to eq("test@example.com")
    end

    example "Emailの前後の全角空白を除去する" do
      user = create(:user, email: "\u{3000}test@example.com\u{3000}")
      expect(user.email).to eq("test@example.com")
    end
  end

  describe "#validation" do
    example "Emailに連続＠を含むものはNG" do
      user = build(:user, email: "test@@example.com")
      expect(user).not_to be_valid
    end
    
    example "アルファベットを含む名前はOK" do
      user = build(:user, name: "Smith")
      expect(user).to be_valid
    end
    
    example "記号を含む名前はOK" do
      user = build(:user, name: "試験★")
      expect(user).to be_valid
    end
    
    example "重複したEmailはNG" do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).not_to be_valid
    end

    example "全角文字を含むUIDはNG" do
      user = build(:user, uid: "あいう")
      expect(user).not_to be_valid
    end

    example "重複したUIDはNG" do
      user1 = create(:user)
      user2 = build(:user, uid: user1.uid)
      expect(user2).not_to be_valid
    end

    example "ハイフンやアンダースコアを含むUIDはOK" do
      user = build(:user, uid: "a_b-c")
      expect(user).to be_valid
    end
  end

  describe "follow and unfollow" do
    before do
      @spidey = create(:user)
      @ironman = create(:user)
    end
    
    example "最初はフォローフォロワー関係にない" do
      expect(@spidey.following?(@ironman)).to be_falsey
    end
    example "他の人をフォローすることができる" do
      @spidey.follow(@ironman)
      expect(@spidey.following?(@ironman)).to be_truthy
    end
    example "フォローした人のフォロワーリストに入る" do
      @spidey.follow(@ironman)
      expect(@ironman.followers.include?(@spidey)).to be_truthy
    end
    example "フォロー解除することができる" do
      @spidey.follow(@ironman)
      @spidey.unfollow(@ironman)
      expect(@spidey.following?(@ironman)).to be_falsey
    end
  end

  describe '#feed' do
    let(:spidey) {create :user, :with_commit_activities}
    let(:ironman) {create :user, :with_commit_activities}
    let(:captain) {create :user, :with_commit_activities}
    
    before do
      spidey.follow(ironman)
    end

    example 'フォローしているユーザーのアクティビティが含まれる' do
      ironman.activities.each do |post|
        expect(spidey.feed.include?(post)).to be_truthy
      end
    end

    example '自分自身のアクティビティが含まれる' do
      spidey.activities.each do |post|
        expect(spidey.feed.include?(post)).to be_truthy
      end
    end

    example 'フォローしていないユーザーのアクティビティは含まれない' do
      captain.activities.each do |post|
        expect(spidey.feed.include?(post)).to be_falsey
      end
    end
  end
end
