require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:post2) { create(:post) }
  let!(:like) { create(:like, user_id: user.id, post_id: post.id) }

  describe 'Post CRUD処理' do
    before { sign_in user }

    describe 'Post新規作成' do
      before { visit new_post_path }

      context 'フォームの入力値が正常な場合' do
        it '投稿の新規作成が成功する' do
          fill_in 'おみやげ名', with: 'おみやげ'
          fill_in '購入したお店', with: '場所'
          fill_in 'おみやげ感想', with: '美味しかった'
          within('.button-group') do
            click_button '投稿'
          end
          new_post = Post.last
          expect(current_path).to eq root_path
          expect(page).to have_content new_post.name
          expect(page).to have_content new_post.address
        end
      end

      context 'おみやげ名が未入力の場合' do
        it '投稿の新規作成が失敗する' do
          fill_in 'おみやげ名', with: nil
          fill_in '購入したお店', with: '場所'
          fill_in 'おみやげ感想', with: '美味しかった'
          within('.button-group') do
            click_button '投稿'
          end
          expect(current_path).to eq posts_path
          expect(page).to have_content '投稿に失敗しました'
        end
      end
    end

    describe 'Post一覧表示' do
      it '投稿一覧が表示される' do
        visit root_path
        expect(page).to have_content post.name
        expect(page).to have_content post.address
      end
    end

    describe 'Post詳細表示' do
      context '投稿一覧画面で投稿を押した場合' do
        it 'その投稿の詳細が表示される' do
          visit root_path
          click_on post.name
          expect(current_path).to eq post_path(post)
          expect(page).to have_content post.caption
        end

        it 'その投稿でない投稿は表示されない' do
          visit root_path
          click_on post.name
          expect(current_path).to eq post_path(post)
          expect(page).not_to have_content post2.caption
        end
      end
    end

    describe 'Post編集' do
      before { visit edit_post_path(post) }

      context 'フォームが正常に入力された場合' do
        it '投稿情報編集が成功する' do
          fill_in 'おみやげ名', with: 'おみやげ２'
          click_on '更新'
          expect(current_path).to eq root_path
          expect(page).to have_content '投稿を更新しました'
          expect(page).to have_content 'おみやげ２'
        end
      end

      context 'おみやげ名が未入力の場合' do
        it '投稿情報編集が失敗する' do
          fill_in 'おみやげ名', with: nil
          click_on '更新'
          expect(current_path).to eq post_path(post)
          expect(page).to have_content '投稿に失敗しました'
        end
      end
    end

    describe 'Post削除' do
      it '投稿の削除が成功する' do
        visit post_path(post)
        click_on '削除'
        within '.modal' do
          click_on '削除'
        end
        expect(current_path).to eq root_path
        expect(page).to have_content '投稿を削除しました'
        expect(page).not_to have_content post.name
      end
    end
  end

  describe 'Post 検索機能' do
    before { visit root_path }

    describe 'キーワード検索' do
      context 'おみやげ名を入れて検索した場合' do
        it 'そのおみやげが入った投稿が表示される' do
          fill_in '商品名、場所、投稿内容、ユーザー名', with: post.name
          click_on '検索'
          expect(page).to have_content post.name
        end
      end

      context 'ユーザー名を入れて検索した場合' do
        it 'そのユーザーが投稿した投稿が表示される' do
          fill_in '商品名、場所、投稿内容、ユーザー名', with: user.name
          click_on '検索'
          expect(page).to have_content user.name
        end
      end

      context '投稿に一致しないキーワードで検索した場合' do
        it '投稿が表示されない' do
          fill_in '商品名、場所、投稿内容、ユーザー名', with: 'testtest'
          click_on '検索'
          expect(page).not_to have_content post.name
        end
      end

      context '２つ以上のキーワードを入れて検索した場合' do
        it 'どちらのキーワードも入った投稿が表示される' do
          fill_in '商品名、場所、投稿内容、ユーザー名', with: "#{post.name} #{post.address}"
          click_on '検索'
          expect(page).to have_content post.name
          expect(page).to have_content post.address
        end
      end
    end

    describe '絞り込み検索' do
      context 'おみやげ名を入れて検索した場合' do
        it 'そのおみやげ名が含まれた投稿が表示される' do
          click_on '絞り込み検索'
          fill_in 'おみやげ名', with: post.name
          click_on '詳細検索'
          expect(page).to have_content post.name
        end
      end

      context '期間を入れて検索した場合' do
        it 'その期間の間に投稿された投稿が表示される' do
          click_on '絞り込み検索'
          fill_in 'q[created_at_gteq]', with: post.created_at
          fill_in 'q[created_at_lteq_end_of_day]', with: post.created_at
          click_on '詳細検索'
          expect(page).to have_content post.name
        end
      end

      context '投稿に一致しないキーワードで検索した場合' do
        it 'その投稿は表示されない' do
          click_on '絞り込み検索'
          fill_in 'おみやげ名', with: 'testtest'
          click_on '詳細検索'
          expect(page).not_to have_content post.name
        end
      end

      it '検索条件のリセットに成功する' do
        click_on '絞り込み検索'
        fill_in 'おみやげ名', with: 'testtest'
        click_on 'リセット'
        expect(page).not_to have_field '商品名', with: 'testtest'
      end
    end

    describe 'ソート機能' do
      context '新規投稿順を選択した場合' do
        it '新規投稿の投稿の昇順で表示される' do
          find("option[value='updated_at desc']").select_option
          posts = all('.post-item')
          expect(posts[0]).to have_content post2.name
        end
      end

      context 'いいねの多い順を選択した場合' do
        it 'いいねの多い順の昇順で表示される' do
          find("option[value='likes_count desc']").select_option
          posts = all('.post-item')
          expect(posts[0]).to have_content post.name
        end
      end
    end
  end
end
