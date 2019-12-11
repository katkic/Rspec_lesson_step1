require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録画面' do
    context 'ユーザーを作成した場合' do
      before do
        visit new_user_path
        fill_in '名前', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        fill_in 'パスワード確認', with: 'password!'
        click_on '登録する'
      end
      it 'ユーザー作成後、自動でログインすること' do
        expect(page).to have_content 'ユーザー「ユーザーA」を登録してログインしました'
      end
    end
  end

  describe 'ログイン機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      create(:task1, user: user_a)

      visit new_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
    end

    context 'メールアドレスとパスワードを入力してログインボタンを押したとき' do
      let(:login_user) { user_a }

      it 'ログインできること' do
        expect(page).to have_content 'ログインしました'
      end
    end

    context 'ログイン後にマイページボタンを押したとき' do
      let(:login_user) { user_a }

      before do
        click_on 'マイページ'
      end

      it 'ユーザー詳細画面へ遷移できること' do
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'a@example.com'
      end
    end

    context 'ログイン後に他のユーザーのマイページへ遷移しようとしたとき' do
      let(:login_user) { user_a }

      before do
        visit user_path(user_b)
      end

      it '自分のマイページへ遷移すること' do
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'a@example.com'
      end
    end

    context 'ログイン後にログアウトボタンを押したとき' do
      let(:login_user) { user_a }

      before do
        click_on 'ログアウト'
      end

      it 'ログアウトできること' do
        expect(page).to have_content 'ログアウトしました'
      end
    end

    context 'ログインせずにタスクのページへ遷移しようとした場合' do
      let(:login_user) { user_a }

      before do
        click_on 'ログアウト'
        visit tasks_path
      end

      it 'ログインページへ遷移させること' do
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_content 'ログイン'
      end
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示されること' do
        expect(page).to have_content '植栽1'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されないこと' do
        expect(page).to have_no_content '植栽1'
      end
    end

    context 'ログイン状態でユーザー登録ページへ遷移しようとした場合' do
      let(:login_user) { user_a }

      it 'タスクの一覧画面へ遷移させること' do
        expect(page).to have_content 'タスク一覧'
      end
    end
  end
end
