require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:comment) { create(:comment, post_id: post.id, user_id: user.id) }

  describe 'コメント作成' do
    before do
      sign_in user
      visit post_path(post)
    end

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
        expect(page).to have_content 'コメントの投稿に失敗しました'
      end
    end
  end

  describe 'コメント削除' do
    before do
      sign_in user
      visit post_path(post)
    end

    it 'コメントの削除が成功する' do
      within '.comment_delete' do
        click_on '削除'
      end
      within '.modal' do
        click_on '削除'
      end
      expect(page).to have_content 'コメントを削除しました'
      expect(page).not_to have_content comment.comment
    end
  end
end
