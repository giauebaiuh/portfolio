# frozen_stling_literal :true
require 'rails_helper'

describe 'ユーザー登録のテスト' do
  let!(:user){ FactoryBot.create(:user) }
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