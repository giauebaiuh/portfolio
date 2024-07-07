# frozen_string_literal: true
require 'rails_helper'

describe '投稿に対してコメントができるか' do
  before do
    visit post_image_path(post_image)
  end
  context '表示の確認' do
    it 'コメント入力フィールドと投稿ボタンが存在しているか' do
        expect(page).to have_field 'post_comment[body]'
        expect(page).to have_button 'コメント投稿'
      end
  end
  context 'コメント投稿処理の確認' do
    it '投稿後のリダイレクト先は正しいか' do
      fill_in 'post_comment[body]', with: Faker::Lorem.characters(nunber:10)
      click_button 'コメント投稿'
      expect(page).to have_current_path post_image_path(post_image)
    end
  end
end