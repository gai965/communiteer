require 'rails_helper'

RSpec.describe JoinVolunteer, type: :model do
  before do
    @join_volunteer = FactoryBot.build(:join_volunteer)
  end

  describe 'ボランティア応募機能' do
    context '応募登録が成功する時' do
      it '情報全てが存在すれば登録できる' do
        expect(@join_volunteer).to be_valid
      end

      it '「電話番号」が空でも登録できる' do
        @join_volunteer.phone_number = nil
        expect(@join_volunteer).to be_valid
      end

      it '「問い合わせ」が空でも登録できる' do
        @join_volunteer.inquiry = nil
        expect(@join_volunteer).to be_valid
      end
    end

    context '応募登録が失敗する時' do
      it '名前が「空」だと登録できない' do
        @join_volunteer.name = nil
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('名前を入力してください')
      end

      it '名前が「30文字超える」と登録できない' do
        @join_volunteer.name = Faker::Number.number(digits: 31)
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('名前は30文字以内で入力してください')
      end

      it '電話番号は「9桁以下」だと登録できない' do
        @join_volunteer.phone_number = '123456789'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end

      it '電話番号は「12桁以上」だと登録できない' do
        @join_volunteer.phone_number = '012345678901'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end

      it '電話番号は「全角数字」だと登録できない' do
        @join_volunteer.phone_number = '１２３４５６７８９'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('電話番号は10桁または11桁の半角数字で入力してください')
      end

      it '参加人数が「空」だと登録できない' do
        @join_volunteer.number = nil
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('参加人数を入力してください')
      end

      it '参加人数が「0」だと登録できない' do
        @join_volunteer.number = 0
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('参加人数は0より大きい値にしてください')
      end

      it '参加人数が「0未満」だと登録できない' do
        @join_volunteer.number = -1
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('参加人数は0より大きい値にしてください')
      end

      it '問い合わせが「100文字超える」と登録できない' do
        @join_volunteer.inquiry = Faker::Number.number(digits: 101)
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('問い合わせは100文字以内で入力してください')
      end
    end
  end
end
