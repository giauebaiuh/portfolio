# frozen_string_literal: true
require 'rails_helper'

describe '投稿のテスト' do
  let!(:user){ FactoryBot.create(:user) }
  let!(:post_image){ FactoryBot.create(:post_image, user: user)}

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
  describe '新規投稿画面のテスト' do
    before do
      sign_in user
      visit new_post_image_path
    end
    context '表示の確認' do
      it '"new_post_image_path"が"/post_images/new"であるか' do
        expect(current_path).to eq('/post_images/new')
      end
      it '「投稿」ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
      it '投稿後のリダイレクト先は正しいか', js: true do
        attach_file 'post_image[image]', ('app/assets/images/no_image.jpg')
        select '北海道', from: "post_image[prefecture]"
        select '和菓子', from: "post_image[genre]"
        fill_in 'post_image[trade_name]', with: Faker::Lorem.characters(number: 5)
        find("img[alt='3']").click
        fill_in 'post_image[caption]',with: Faker::Lorem.characters(number: 10)
        click_button '投稿'
        expect(page).to have_current_path post_image_path(PostImage.last)
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit post_images_path
    end
    context '表示とリンクの確認' do
      it '投稿されたものの一覧と正しくリンクがあるか' do
        expect(page).to have_content post_image.trade_name
        click_link post_image.trade_name
        expect(current_path).to eq('/post_images/' + post_image.id.to_s)
      end
    end
    context '検索機能が正しく実行されるか' do
      it '検索内容と一致するデータを返すか' do
        select '北海道'
        select '和菓子'
        expect(page).to have_content '北海道'
        expect(page).to have_content '和菓子'
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      sign_in user
      visit post_image_path(post_image)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '投稿削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集ボタンの遷移先は編集画面か' do
        click_link '編集'
        expect(current_path).to eq('/post_images/' + post_image.id.to_s + '/edit')
      end
    end
    context '削除ボタンのテスト' do
      it '削除テスト' do
        visit new_post_image_path
        attach_file 'post_image[image]', ('app/assets/images/no_image.jpg')
        select '北海道', from: "post_image[prefecture]"
        select '和菓子', from: "post_image[genre]"
        fill_in 'post_image[trade_name]', with: Faker::Lorem.characters(number: 5)
        find("img[alt='3']").click
        fill_in 'post_image[caption]',with: Faker::Lorem.characters(number: 10)
        click_button '投稿'
        click_link '投稿削除'
        page.driver.browser.switch_to.alert.accept
        expect{ post_image.destroy }.to change{ PostImage.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      sign_in user
      visit edit_post_image_path(post_image)
    end
    context '表示の確認' do
      it '編集前の情報が入力されているか' do
        expect(page).to have_content post_image.prefecture
        expect(page).to have_content post_image.genre
        expect(page).to have_field 'post_image[trade_name]', with: post_image.trade_name
        find(".form-group")
        expect(page).to have_field 'post_image[caption]', with: post_image.caption
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '編集処理に関するテスト' do
      it '編集後のリダイレクト先は正しいか' do
        select '青森県', from: "post_image[prefecture]"
        select '洋菓子', from: "post_image[genre]"
        fill_in 'post_image[trade_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post_image[caption]',with: Faker::Lorem.characters(number: 10)
        click_button '投稿'
        expect(page).to have_current_path post_image_path(post_image)
      end
    end
  end

  describe '投稿に対してコメントができるか' do
    before do
      sign_in user
      visit post_image_path(post_image)
    end
    context '表示の確認' do
      it 'と投稿ボタンが存在しているか' do
        expect(page).to have_button 'コメント投稿'
      end
    end
    context 'コメント投稿処理の確認' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post_comment[body]', with: Faker::Lorem.characters(number:10)
        click_button 'コメント投稿'
        expect(page).to have_current_path post_image_path(post_image)
      end
    end
  end
end