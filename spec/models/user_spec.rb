require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる'  do
      expect(@user).to be_valid
    end

    it 'nameが空では登録できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字以上あれば登録できる' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordとpassword_confirmationが不一致であれば登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'bbbbbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '重複したemailが存在する場合には登録できない' do
      user2 = FactoryBot.create(:user)
      @user.email = user2.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

  end
end
