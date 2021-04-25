require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録が成功する時' do
      it '情報全てが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'パスワードは、半角英数字で小文字と大文字の混合での入力で登録できる' do
        @user.password = '1234Ab'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context '新規登録が失敗する時' do
      it 'ニックネームが「空」だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'ニックネームが「一意性でない」と登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.nickname = @user.nickname
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Nickname has already been taken')
      end

      it 'メールアドレスが「空」だと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが「一意性でない」と登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは「@を含まない」と登録できない' do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが「空」だと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは「6文字以下」だと登録できない' do
        @user.password = '123Ab'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは「半角数字のみ」だと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英字のみ」だと登録できない' do
        @user.password = 'abcABC'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英小文字のみ」だと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英大文字のみ」だと登録できない' do
        @user.password = 'ABCDEF'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英数字の小文字のみ」だと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「半角英数字の大文字のみ」だと登録できない' do
        @user.password = '123ABC'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「全角英文字が含まれる」だと登録できない' do
        @user.password = '1234Ａｂ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include all uppercase and lowercase letters and numbers')
      end

      it 'パスワードは「確認用を含めて2回入力しない」と登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードとパスワード（確認用）の「値の一致しない」と登録できない' do
        @user.password_confirmation = FactoryBot.build(:user).password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
