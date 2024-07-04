# frozen_string_literal: true
require 'rails_helper'

describe '投稿のテスト' do
  let!(:post_image){ FactoryBot.create(:post_image)}

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面に「推しおみや」と表示されているか' do
        expect(page).to have_content '推しおみや'
      end
      it 'トップページがルートパスになっているか' do
        expect(current_path).to eq('/')
      end
      it 'ログイン、サインアップ、ゲストログインページのリンク先が存在しているか' do
        expect(page).to have_link 'ゲストログイン'
        expect(page).to have_link 'サインアップ'
        expect(page).to have_link 'ゲストログイン'
      end
    end
    context 'リンク遷移先の確認' do
      it 'ログインの遷移先はログイン画面か' do
        click_link 'ログイン'
        expect(current_path).to eq('/users/sign_in')
      end
      it 'サインアップの遷移先はサインアップ画面か' do
        click_link('サインアップ', class: 'btn')
        expect(current_path).to eq('/users/sign_up')
      end
      it 'ゲストログインの遷移先はインデックス画面か' do
        click_link 'ゲストログイン'
        expect(current_path).to eq('/post_images')
      end
    end
  end
end