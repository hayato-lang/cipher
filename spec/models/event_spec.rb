require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'イベント投稿' do
    before do
      @event = FactoryBot.build(:event)
    end
    context 'イベント投稿できるとき' do
      it 'event_image, name, event_date, contentが存在していれば保存できる' do
        expect(@event).to be_valid
      end
      it 'event_dateが明日以降であれば保存できる' do
        @event.event_date = '2022-06-05 14:00:00'
        expect(@event).to be_valid
      end
    end
    context 'イベント投稿できないとき' do
      it 'nameが空では保存できない' do
        @event.name = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Name can't be blank")
      end
      it 'event_imageが空では保存できない' do
        @event.event_image = nil
        @event.valid?
        expect(@event.errors.full_messages).to include("Event image can't be blank")
      end
      it 'event_dateが空では保存できない' do
        @event.event_date = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Event date can't be blank")
      end
      it 'event_dateが今日以前では保存できない' do
        @event.event_date = '2021-01-10 19:00:00'
        @event.valid?
        expect(@event.errors.full_messages).to include("Event date 明日以降の日付を入力してください")
      end
      it 'contentが空では保存できない' do
        @event.content = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Content can't be blank")
      end
    end
  end
end
