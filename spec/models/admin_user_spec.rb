require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @admin_user = FactoryBot.build(:admin_user)
    end
    context '新規登録できるとき' do
      it 'store_nameとemail、passwordがあれば登録できる' do
        expect(@admin_user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上あれば登録できる' do
        @admin_user.password = '123abc'
        @admin_user.password_confirmation = '123abc'
        expect(@admin_user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'store_nameが空では登録できない' do
        @admin_user.store_name = ''
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include("Store name can't be blank")
      end
      it 'emailが空では登録できない' do
        @admin_user.email = ''
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @admin_user.save
        another_user = FactoryBot.build(:admin_user)
        another_user.email = @admin_user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailには@を含む記述でなければ登録できない' do
        @admin_user.email = 'test'
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @admin_user.password = ''
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword_confirmationが5文字以下では登録できない' do
        @admin_user.password = '123ab'
        @admin_user.password_confirmation = '123ab'
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが半角英数字が混合されていなければ登録できない' do
        @admin_user.password = '111111'
        @admin_user.password_confirmation = '111111'
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword_confirmationが全角では登録できない' do
        @admin_user.password = '１２３ａｂｃ'
        @admin_user.password_confirmation = '１２３ａｂｃ'
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @admin_user.password = '111aaa'
        @admin_user.password_confirmation = ''
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @admin_user.password = '111aaa'
        @admin_user.password_confirmation = '222bbb'
        @admin_user.valid?
        expect(@admin_user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
