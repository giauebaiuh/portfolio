# frozen_string_literal: true
require 'rails_helper'

describe '投稿のテスト' do
  let!(:post_image){ FactoryBot.create(:post_image)}
  describe 'トップ画面へのテスト' do
    before do
      visit top_path
    end
    context '表示の確認' do
      it 'トップ画面に「推しおみや」と表示されているか' do
        expect(page).to have_content '推しおみや'
      end
      it 'トップページがルートパスになっているか' do
        expect(current_path).to eq('/')
      end
    end
  end
end