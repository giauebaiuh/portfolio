# frozen_stling_literal :true
require 'rails_helper'

describe 'ユーザーに関するテスト' do
  let!(:user){ FactoryBot.create(:user) }
  let!(:post_image){ FactoryBot.create(:post_image, user: user) }
  let!(:post_comment){ FactoryBot.create(:post_comment, post_image: post_image) }
  describe 'ユーザー登録のテスト' do
    before do
      visit new_user_registration_path
    end
    context 'ユーザー新規登録のテスト' do
      it '新規登録が完了するとマイページに遷移するか' do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'abcdef'
        fill_in 'user[password_confirmation]', with: 'abcdef'
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
        expect(current_path).to eq('/users/' + (user.id + 1).to_s)
      end
    end
  end

  describe 'ユーザー詳細画面のテスト' do
    before do
      sign_in user
      visit user_path(user)
    end
    context '画面のテスト' do
      it '詳細画面のURLは正しいか' do
        expect(current_path).to eq('/users/' + (user.id).to_s )
      end
      it '詳細画面に名前とコメントが表示されているか' do
        expect(page).to have_content user.name
        expect(page).to have_content user.user_comment
      end
      it '編集ボタンは存在しており、リンク先が正しいか' do
        expect(page).to have_link 'ユーザー情報編集'
        expect(current_path).to eq('/users/' + (user.id).to_s)
      end
      it 'ユーザーの投稿一覧は表示されているか' do
        find('.post_image-toggler').click
        expect(page).to have_link post_image.trade_name
      end
      it 'ユーザーのコメント一覧は表示されているか' do
        find('.post_comment-toggler').click
        expect(page).to have_link post_comment.body
      end
    end
  end
end