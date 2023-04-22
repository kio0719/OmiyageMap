require 'rails_helper'

RSpec.describe "Likes", type: :system, js: true do
  let(:user) { create(:user) }
  let(:liked_post) { create(:post) }
  let(:not_liked_post) { create(:post) }
  let!(:like) { create(:like, post_id: liked_post.id, user_id: user.id) }

  before { sign_in user }

  describe 'ログインユーザーのプロフィールページ' do
    before do
      visit users_profile_path(user.id)
      click_on 'いいねした投稿一覧'
    end

    it 'いいねした投稿が表示される' do
      expect(page).to have_content liked_post.name
      expect(page).to have_content liked_post.address
    end

    it 'いいねしていない投稿は表示されない' do
      expect(page).not_to have_content not_liked_post.name
      expect(page).not_to have_content not_liked_post.address
    end
  end

  describe '他ユーザーの投稿詳細ページ' do
    context '投稿にいいねがされていない場合', js: true do
      it '投稿にいいねがつく' do
        visit post_path(not_liked_post)
        find('div.like-button').click
        expect(page).not_to have_selector '.like-red-color', text: 0
        expect(page).to have_selector '.like-red-color', text: 1
      end
    end

    context '投稿にいいねがされている場合', js: true do
      it '投稿のいいねが消える' do
        visit post_path(liked_post)
        find('div.like-button').click
        expect(page).not_to have_selector '.like-red-color', text: 1
        expect(page).to have_selector '.like-red-color', text: 0
      end
    end
  end
end
