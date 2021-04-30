require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  include ActionDispatch::TestProcess::FixtureFile

  before do
    @volunteer = FactoryBot.build(:volunteer)
    @volunteer.image = fixture_file_upload('app/assets/images/test/test.jpeg')
  end

  describe 'ボランティア募集投稿' do
    context '投稿登録が成功する時' do
      it '情報全てが存在すれば登録できる' do
        expect(@volunteer).to be_valid
      end

      it '「画像なし」でも登録できる' do
        @volunteer.image = nil
        expect(@volunteer).to be_valid
      end

      it '「内容詳細」が空でも登録できる' do
        @volunteer.details = nil
        expect(@volunteer).to be_valid
      end

      it '「活動時間」が空でも登録できる' do
        @volunteer.start_time = nil
        @volunteer.end_time = nil
        expect(@volunteer).to be_valid
      end

      it '「必要経費」が空でも登録できる' do
        @volunteer.expenses = nil
        expect(@volunteer).to be_valid
      end

      it '「応募条件」が空でも登録できる' do
        @volunteer.conditions = nil
        expect(@volunteer).to be_valid
      end
    end

    context '投稿登録が失敗する時' do
      it '募集名が「空」だと登録できない' do
        @volunteer.title = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include("Title can't be blank")
      end

      it '募集名が「50文字超える」と登録できない' do
        @volunteer.title = Faker::Number.number(digits: 51)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Title is too long (maximum is 50 characters)')
      end

      it '活動場所が「空」だと登録できない' do
        @volunteer.place = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include("Place can't be blank")
      end

      it '活動場所が「50文字超える」と登録できない' do
        @volunteer.place = Faker::Number.number(digits: 51)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Place is too long (maximum is 50 characters)')
      end

      it '内容詳細が「10000文字超える」と登録できない' do
        @volunteer.details = Faker::Number.number(digits: 10_001)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Details is too long (maximum is 10000 characters)')
      end

      it '活動日が「空」だと登録できない' do
        @volunteer.schedule = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include("Schedule can't be blank")
      end

      it '活動日が「本日」だと登録できない' do
        @volunteer.schedule = Faker::Date.between(from: Date.today, to: Date.today)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Schedule select a date after tomorrow')
      end

      it '活動時間の「終了時間だけ」だと登録できない' do
        @volunteer.start_time = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Start time is also required')
      end

      it '活動時間の「開始時間が終了時間より遅い」と登録できない' do
        @volunteer.start_time = Faker::Time.between_dates(from: Date.today, to: Date.today, period: :night)
        @volunteer.end_time = Faker::Time.between_dates(from: Date.today, to: Date.today, period: :day)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Start time enter a time earlier than the end time')
      end

      it '必要経費が「50文字超える」と登録できない' do
        @volunteer.expenses = Faker::Number.number(digits: 51)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Expenses is too long (maximum is 50 characters)')
      end

      it '募集人数が「空」だと登録できない' do
        @volunteer.application_people = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include("Application people can't be blank")
      end

      it '募集人数が「0」だと登録できない' do
        @volunteer.application_people = 0
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Application people must be greater than 0')
      end

      it '募集人数が「0未満」だと登録できない' do
        @volunteer.application_people = -1
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Application people must be greater than 0')
      end

      it '応募条件が「100文字超える」と登録できない' do
        @volunteer.conditions = Faker::Number.number(digits: 101)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Conditions is too long (maximum is 100 characters)')
      end

      it '募集締切日が「空」だと登録できない' do
        @volunteer.deadline = nil
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include("Deadline can't be blank")
      end

      it '募集締切日が「活動日より遅い」と登録できない' do
        @volunteer.schedule = Faker::Date.between(from: Date.today + 1, to: Date.today + 1)
        @volunteer.deadline = Faker::Date.between(from: Date.today + 2, to: Date.today + 2)
        @volunteer.valid?
        expect(@volunteer.errors.full_messages).to include('Deadline select a date after activity day')
      end
    end
  end
end
