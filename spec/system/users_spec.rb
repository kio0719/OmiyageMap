require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'User CRUD処理' do
    describe 'ログイン前' do
      describe 'ユーザー新規作成' do
        before { visit new_user_registration_path }

        context 'フォームの入力値が正常な場合' do
          it 'ユーザーの新規作成が成功する' do
            fill_in '名前', with: 'test'
            fill_in 'メールアドレス', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'password'
            click_on '登録'
            new_user = User.last
            expect(current_path).to eq users_profile_path(new_user)
            expect(page).to have_content new_user.name
          end
        end

        context 'メールアドレスが未入力の場合' do
          it 'ユーザーの新規作成が失敗する' do
            fill_in '名前', with: 'test'
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'password'
            click_on '登録'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end

        context 'すでに登録されているメールアドレスを使用した場合' do
          it 'ユーザーの新規作成が失敗する' do
            fill_in '名前', with: 'test'
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード（確認用）', with: 'password'
            click_on '登録'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content 'メールアドレスはすでに存在します'
          end
        end
      end
    end

    describe 'ログイン後' do
      describe 'プロフィール編集' do
        before do
          sign_in user
          visit users_profile_edit_path
        end

        context 'フォームが正常に入力された場合' do
          it 'プロフィール編集が成功する' do
            fill_in '名前', with: 'test2'
            click_on '更新'
            expect(current_path).to eq users_profile_path(user)
            expect(page).to have_content 'test2'
          end
        end

        context '名前が未記入の場合' do
          it 'プロフィール編集が失敗する' do
            fill_in '名前', with: nil
            click_on '更新'
            expect(current_path).to eq users_profile_update_path
            expect(page).to have_content '名前を入力してください'
          end
        end
      end

      describe 'アカウント情報編集' do
        before do
          sign_in user
          visit edit_user_registration_path
        end

        context 'フォームが正常に入力された場合' do
          it 'アカウント情報編集画が成功する' do
            fill_in 'メールアドレス', with: 'test2@example.com'
            fill_in 'パスワード変更', with: 'password2'
            fill_in 'パスワード変更(確認)', with: 'password2'
            fill_in '現在のパスワード', with: user.password
            click_on '変更する'
            expect(current_path).to eq edit_user_registration_path
            expect(page).to have_field 'メールアドレス', with: 'test2@example.com'
          end
        end

        context 'メールアドレスが未入力の場合' do
          it 'アカウント情報編集が失敗する' do
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード変更', with: 'password2'
            fill_in 'パスワード変更(確認)', with: 'password2'
            fill_in '現在のパスワード', with: user.password
            click_on '変更する'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content 'メールアドレスを入力してください'
          end
        end
      end

      describe 'ユーザー退会' do
        it 'ユーザーのアカウント削除が成功する' do
          sign_in user
          visit users_profile_path(user)
          find('.dropdown-toggle').click
          click_on '退会する'
          click_on '削除'
          click_on 'ログイン'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          within('.d-flex') do
            click_on 'ログイン'
          end
          expect(current_path).not_to eq root_path
        end
      end
    end
  end

  describe 'ログイン処理' do
    context 'ユーザー登録している場合' do
      it 'ログインが成功する' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        within('.d-flex') do
          click_on 'ログイン'
        end
        expect(current_path).to eq root_path
        expect(page).to have_selector '.nav-item', text: user.name
      end
    end

    context 'ユーザー登録していない場合' do
      it 'ログインが失敗する' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        within('.d-flex') do
          click_on 'ログイン'
        end
        expect(current_path).not_to eq root_path
      end
    end

    context 'ゲストログインをクリックした場合' do
      it 'ゲストログインが成功する' do
        visit root_path
        click_on 'ゲストログイン'
        expect(current_path).to eq root_path
        expect(page).to have_selector '.nav-item', text: 'ゲストユーザー'
      end
    end
  end
end
