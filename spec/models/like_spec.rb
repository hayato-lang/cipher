require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね機能' do
    before do
      @like = FactoryBot.build(:like)
    end
    context 'いいねをクリックした場合', js: true do
      it 'いいねできる' do
        find('like-btn').click
        expect(page).to have_css ''
      end
    end
    context 'いいねを削除した場合', js: true do
      it 'いいねを取り消せる' do
      end
    end
  end
end
