require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:not_followed_user) { create(:user) }
  let(:following_user) { create(:user) }
  let(:not_following_user) { create(:user) }
  let!(:relationship) { create(:relationship, following_id: user.id, follower_id: followed_user.id) }
  let!(:relationship2) { create(:relationship, following_id: following_user.id, follower_id: user.id) }

  before { sign_in user }

  describe 'ログインユーザーのプロフィールページ' do
    before { visit users_profile_path(user.id) }

    it 'フォローした人が表示される' do
      click_on 'フォロー'
      expect(page).to have_content followed_user.name
    end

    it 'フォローしていない人は表示されない' do
      click_on 'フォロー'
      expect(page).not_to have_content not_followed_user.name
    end

    it 'フォロワーが表示される' do
      click_on 'フォロワー'
      expect(page).to have_content following_user.name
    end

    it 'フォロワーでない人は表示されない' do
      click_on 'フォロワー'
      expect(page).not_to have_content not_following_user.name
    end
  end

  describe '他ユーザーのプロフィールページ' do
    context 'ログインユーザーがそのユーザーをフォローしていない場合' do
      it 'そのユーザーをフォローする' do
        visit users_profile_path(not_followed_user.id)
        click_on 'フォローする'
        expect(page).to have_content 'フォロー済み'
        expect(page).not_to have_content 'フォローする'
        expect(page).to have_content '1フォロワー'
      end
    end

    context 'ログインユーザーがそのユーザーをフォローしている場合' do
      it 'そのユーザーのフォロー解除する' do
        visit users_profile_path(followed_user.id)
        click_on 'フォロー済み'
        expect(page).to have_content 'フォローする'
        expect(page).not_to have_content 'フォロー済み'
        expect(page).to have_content '0フォロワー'
      end
    end
  end
end
