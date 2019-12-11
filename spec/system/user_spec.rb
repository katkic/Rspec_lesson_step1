require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録画面' do
    context 'ユーザーを作成した場合' do
      it 'ユーザー作成後、自動でログインすること' do
        visit new_user_path
        fill_in '名前', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        fill_in 'パスワード確認', with: 'password!'
        click_on '登録する'

        expect(page).to have_content 'ユーザー「ユーザーA」を登録してログインしました'
      end
    end
  end

  describe 'ログイン機能' do
    before do
      user_a = create(:user)
      @user_b = create(:user, name: 'ユーザーB', email: 'b@example.com')

      create(:task1, user: user_a)
    end

    context 'メールアドレスとパスワードを入力してログインボタンを押したとき' do
      it 'ログインできること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'

        expect(page).to have_content 'ログインしました'
      end
    end

    context 'ログイン後にマイページボタンを押したとき' do
      it 'ユーザー詳細画面へ遷移できること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'
        click_on 'マイページ'

        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'a@example.com'
      end
    end

    context 'ログイン後に他のユーザーのマイページへ遷移しようとしたとき' do
      it '自分のマイページへ遷移すること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'
        visit user_path(@user_b)

        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'a@example.com'
      end
    end

    context 'ログイン後にログアウトボタンを押したとき' do
      it 'ログアウトできること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'
        click_on 'ログアウト'

        expect(page).to have_content 'ログアウトしました'
      end
    end

    context 'ログインせずにタスクのページへ遷移しようとした場合' do
      it 'ログインページへ遷移させること' do
        visit tasks_path

        expect(page).to have_content 'ログインしてください'
        expect(page).to have_content 'ログイン'
      end
    end

    context 'ユーザーAがログインしているとき' do
      it 'ユーザーAが作成したタスクが表示されること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'

        expect(page).to have_content '植栽1'
      end
    end

    context 'ユーザーBがログインしているとき' do
      it 'ユーザーAが作成したタスクが表示されないこと' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'

        expect(page).to have_no_content '植栽1'
      end
    end

    context 'ログイン状態でユーザー登録ページへ遷移しようとした場合' do
      it 'タスクの一覧画面へ遷移させること' do
        visit new_session_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        click_on 'ログイン'

        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end
