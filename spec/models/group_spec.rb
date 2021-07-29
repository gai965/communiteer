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
      before do
        @another_group = FactoryBot.build(:group)
        @another_group.email = @group.email
      end

      it '名前が「空」だと登録できない' do
        @group.name = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('名前を入力してください')
      end

      it 'メールアドレスが「空」だと登録できない' do
        @group.email = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it 'メールアドレスが「一意性でない」と登録できない' do
        @group.save
        @another_group.valid?
        expect(@another_group.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'メールアドレスは「@を含まない」と登録できない' do
        @group.email = 'test.test'
        @group.valid?
        expect(@group.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it '電話番号は「空」だと登録できない' do
        @group.phone_number = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('電話番号を入力してください')
      end

      it '電話番号は「9桁以下」だと登録できない' do
        @group.phone_number = '123456789'
        @group.valid?
        expect(@group.errors.full_messages).to include('電話番号文字制限に適用されます')
      end

      it '電話番号は「12桁以上」だと登録できない' do
        @group.phone_number = '012345678901'
        @group.valid?
        expect(@group.errors.full_messages).to include('電話番号文字制限に適用されます')
      end

      it '電話番号は「全角数字」だと登録できない' do
        @group.phone_number = '１２３４５６７８９'
        @group.valid?
        expect(@group.errors.full_messages).to include('電話番号文字制限に適用されます')
      end

      it '住所が「空」だと登録できない' do
        @group.base_address = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('住所を入力してください')
      end

      it 'HPアドレスに「httpまたはhttpsが含まれない」と登録できない' do
        @group.url = 'htp'
        @group.valid?
        expect(@group.errors.full_messages).to include('ホームページアドレスの頭字語に「http」または「https」を含めてください')
      end

      it 'カテゴリーが「空」だと登録できない' do
        @group.group_category = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('カテゴリーを選択してください')
      end

      it 'パスワードが「空」だと登録できない' do
        @group.password = nil
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'パスワードは「6文字以下」だと登録できない' do
        @group.password = '123Ab'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードは「半角数字のみ」だと登録できない' do
        @group.password = '123456'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「半角英字のみ」だと登録できない' do
        @group.password = 'abcABC'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「半角英小文字のみ」だと登録できない' do
        @group.password = 'abcdef'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「半角英大文字のみ」だと登録できない' do
        @group.password = 'ABCDEF'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「半角英数字の小文字のみ」だと登録できない' do
        @group.password = '123abc'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「半角英数字の大文字のみ」だと登録できない' do
        @group.password = '123ABC'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「全角英文字が含まれる」と登録できない' do
        @group.password = '1234Ａｂ'
        @group.password_confirmation = @group.password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワードは大文字を含む英字と数字を入力してください')
      end

      it 'パスワードは「確認用を含めて2回入力しない」と登録できない' do
        @group.password_confirmation = ''
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワードとパスワード（確認用）の「値の一致しない」と登録できない' do
        @group.password_confirmation = FactoryBot.build(:group).password
        @group.valid?
        expect(@group.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
