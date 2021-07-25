require 'rails_helper'

RSpec.describe AdminProfile, type: :model do
  describe 'プロフィール情報の保存' do
    before do
      admin_user = FactoryBot.create(:admin_user)
      @admin_profile = FactoryBot.create(:admin_profile, admin_user_id: admin_user.id)
      sleep(0.5)
    end
    context 'プロフィール情報の登録ができる場合' do
      it '全ての情報が正しく入力されていれば登録できること' do
        expect(@admin_profile).to be_valid
      end
      it 'building_nameが空でも登録できること' do
        @admin_profile.building_name = ''
        expect(@admin_profile).to be_valid
      end
    end
    context 'プロフィール情報の登録ができない場合' do
      it "admin_imageが空では登録できないこと" do
        @admin_profile.admin_image = nil
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Admin image can't be blank")
      end
      it "postal_codeが空では登録できないこと" do
        @admin_profile.postal_code = ''
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeが半角のハイフンを含んだ正しい形式でなければ登録できないこと" do
        @admin_profile.postal_code = "1234567"
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeが半角のハイフンを含んだ9文字以上では登録できないこと" do
        @admin_profile.postal_code = "1234-5678"
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeが半角のハイフンを含んだ6文字以下では登録できないこと" do
        @admin_profile.postal_code = "123-456"
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeが全角では登録できないこと" do
        @admin_profile.postal_code = "１２３－４５６７"
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeが数値でないと登録できないこと" do
        @admin_profile.postal_code = "abc-defg"
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Postal code is invalid")
      end
      it "prefecure_idが空では登録できないこと" do
        @admin_profile.prefecture_id = nil
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "prefecture_idが1では登録できないこと" do
        @admin_profile.prefecture_id = 1
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "municipalityが空では登録できないこと" do
        @admin_profile.municipality = ''
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Municipality can't be blank")
      end
      it "addressが空では登録できないこと" do
        @admin_profile.address = ''
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberが空では登録できないこと" do
        @admin_profile.phone_number = ''
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberが12桁以上の数値では登録できないこと" do
        @admin_profile.phone_number = '090123456789'
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが9桁以下では登録できないこと" do
        @admin_profile.phone_number = '090123456'
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが数字のみでないと登録できないこと（英数字混合）" do
        @admin_profile.phone_number = '090abcdefgh'
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが数字のみでないと登録できないこと（ハイフンあり）" do
        @admin_profile.phone_number = '09-123-4567'
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberが全角文字では登録できないこと" do
        @admin_profile.phone_number = '０９０１２３４５６７８'
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Phone number is invalid")
      end
      it "profileが空では保存できないこと" do
        @admin_profile.profile = ''
        @admin_profile.valid?
        expect(@admin_profile.errors.full_messages).to include("Profile can't be blank")
      end
    end
  end
end
