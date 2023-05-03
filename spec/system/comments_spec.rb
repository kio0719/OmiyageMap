require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user) { create(:user) }
  let(:commented_post) { create(:post) }
  let(:not_commented_post) { create(:post) }
  let!(:comment) { create(:comment, post_id: commented_post.id, user_id: user.id) }

  describe 'ログインユーザーのプロフィールページ' do
    before { visit users_profile_path(user.id) }

    it 'コメントした投稿が表示される' do
      click_on 'コメントした投稿一覧'
      expect(page).to have_content commented_post.name
      expect(page).to have_content commented_post.address
    end

    it 'コメントしていない投稿は表示されない' do
      click_on 'コメントした投稿一覧'
      expect(page).not_to have_content not_commented_post.name
      expect(page).not_to have_content not_commented_post.address
    end
  end

  describe '他ユーザーの投稿ページ' do
    before do
      sign_in user
      visit post_path(commented_post)
    end

    describe 'コメントの新規作成' do
      context 'フォームの入力値が正常な場合' do
        it 'コメントの新規作成が成功する' do
          fill_in 'comment[comment]', with: 'コメントコメント'
          click_on 'コメントする'
          expect(page).to have_content 'コメントコメント'
        end
      end
      context 'フォームの入力値が空な場合' do
        it 'コメントの新規作成が失敗する' do
          fill_in 'comment[comment]', with: nil
          click_on 'コメントする'
          expect(page).to have_content 'コメントを入力してください'
        end
      end
    end

    describe 'コメント削除' do
      it 'コメントの削除が成功する' do
        within '.comment_btn' do
          click_on '削除'
        end
        within '.comment_delete_modal' do
          click_on '削除'
        end
        expect(page).not_to have_content comment.comment
      end
    end
  end
end
