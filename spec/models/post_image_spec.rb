# frozen_string_literal: true
require 'rails_helper'

describe 'モデルのテスト' do
  it '有効な投稿内容は保存されるか' do
    expect(FactoryBot.build(:post_image)).to be_valid
  end
end