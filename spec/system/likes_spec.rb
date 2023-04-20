require 'rails_helper'

RSpec.describe "Likes", type: :system, js: true  do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:post2) { create(:post) }
  let!(:like) { create(:like, post_id: post2.id, user_id: user.id) }

  before do
    sign_in user
  end

  context '投稿にいいねがされていない場合', js: true do
    it '投稿にいいねがつく' do
      visit post_path(post)
      find('div.like-button').click
      expect(page).not_to have_selector '.like-red-color', text: 0
      expect(page).to have_selector '.like-red-color', text: 1
    end
  end

  context '投稿にいいねがされている場合', js: true do
    it '投稿のいいねが消える' do
      visit post_path(post2)
      find('div.like-button').click
      expect(page).not_to have_selector '.like-red-color', text: 1
      expect(page).to have_selector '.like-red-color', text: 0
    end
  end
end
