require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @group = FactoryBot.build(:group)
  end

  describe '新規登録/団体情報' do
    context '新規登録が成功する時' do
      it '情報全てが存在すれば登録できる' do
        expect(@group).to be_valid
      end

      it 'パスワードは、半角英数字で小文字と大文字の混合での入力で登録できる' do
        @group.password = '1234Ab'
        @group.password_confirmation = @group.password
        expect(@group).to be_valid
      end
    end

    context '新規登録が失敗する時' do
      it '名前が「空」だと登録できない' do
        @group.name = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Name can't be blank")
      end

      it 'メールアドレスが「空」だと登録できない' do
        @group.email = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが「一意性でない」と登録できない' do
        @group.save
        another_group = FactoryBot.build(:group)
        another_group.email = @group.email
        another_group.valid?
        expect(another_group.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは「@を含まない」と登録できない' do
        @group.email = 'test.test'
        @group.valid?
        expect(@group.errors.full_messages).to include('Email is invalid')
      end

      it '電話番号は「空」だと登録できない' do
        @group.phone_number = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は「9桁以下」だと登録できない' do
        @group.phone_number = '123456789'
        @group.valid?
        expect(@group.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '電話番号は「12桁以上」だと登録できない' do
        @group.phone_number = '012345678901'
        @group.valid?
        expect(@group.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '電話番号は「全角数字」だと登録できない' do
        @group.phone_number = '１２３４５６７８９'
        @group.valid?
        expect(@group.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '住所が「空」だと登録できない' do
        @group.base_address = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Base address can't be blank")
      end

      it 'HPアドレスに「"http"または"https"が含まれない」と登録できない' do
        @group.url = 'htp'
        @group.valid?
        expect(@group.errors.full_messages).to include('Url Include "http" or "https" in the acronym')
      end

      it 'カテゴリーが「空」だと登録できない' do
        @group.group_category = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('Group category Select')
      end

      it 'パスワードが「空」だと登録できない' do
        @group.password = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは「6文字以下」だと登録できない' do
        @group.password = '123Ab'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは「半角数字のみ」だと登録できない' do
        @group.password = '123456'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英字のみ」だと登録できない' do
        @group.password = 'abcABC'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英小文字のみ」だと登録できない' do
        @group.password = 'abcdef'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英大文字のみ」だと登録できない' do
        @group.password = 'ABCDEF'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英数字の小文字のみ」だと登録できない' do
        @group.password = '123abc'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英数字の大文字のみ」だと登録できない' do
        @group.password = '123ABC'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「全角英文字が含まれる」と登録できない' do
        @group.password = '1234Ａｂ'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「確認用を含めて2回入力しない」と登録できない' do
        @group.password_confirmation = ''
        @group.valid?
        expect(@group.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードとパスワード（確認用）の「値の一致しない」と登録できない' do
        @group.password_confirmation = FactoryBot.build(:group).password
        @group.valid?
        expect(@group.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
