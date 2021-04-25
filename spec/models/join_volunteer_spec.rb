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
        expect(@join_volunteer.errors.full_messages).to include("Name can't be blank")
      end

      it '名前が「30文字超える」と登録できない' do
        @join_volunteer.name = Faker::Number.number(digits: 31)
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('Name is too long (maximum is 30 characters)')
      end

      it '電話番号は「9桁以下」だと登録できない' do
        @join_volunteer.phone_number = '123456789'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '電話番号は「12桁以上」だと登録できない' do
        @join_volunteer.phone_number = '012345678901'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '電話番号は「全角数字」だと登録できない' do
        @join_volunteer.phone_number = '１２３４５６７８９'
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('Phone number Applies to character restrictions')
      end

      it '参加人数が「空」だと登録できない' do
        @join_volunteer.number = nil
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include("Number can't be blank")
      end

      it '参加人数が「0」だと登録できない' do
        @join_volunteer.number = 0
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include("Number of participants must be greater than 0")
      end

      it '参加人数が「0未満」だと登録できない' do
        @join_volunteer.number = -1
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include("Number of participants must be greater than 0")
      end

      it '問い合わせが「100文字超える」と登録できない' do
        @join_volunteer.inquiry = Faker::Number.number(digits: 101)
        @join_volunteer.valid?
        expect(@join_volunteer.errors.full_messages).to include('Inquiry is too long (maximum is 100 characters)')
      end

    end
  end
end
