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

      it '他のユーザーのマイページへ遷移しないこと' do
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

      it 'ログイン画面へ遷移すること' do
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

      it 'ユーザー登録ページへ遷移しないこと' do
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe '管理画面' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      visit new_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
      visit admin_users_path
    end

    context 'ユーザー一覧を表示した場合' do
      let(:login_user) { user_a }

      it '管理画面で登録ユーザーが表示されていること' do
        expect(page).to have_content '管理画面'
        expect(page).to have_content 'ユーザーA'
      end
    end

    context 'ユーザーを作成した場合' do
      let(:login_user) { user_a }

      before do
        visit new_admin_user_path
        fill_in '名前', with: 'ユーザーB'
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password!'
        fill_in 'パスワード確認', with: 'password!'
        click_on '登録する'
      end

      it '作成したユーザーが登録されていること' do
        expect(page).to have_content '管理画面'
        expect(page).to have_content 'ユーザー「ユーザーB」を登録しました'
        expect(page).to have_content 'ユーザーB'
      end
    end

    context '任意のユーザー詳細ページを表示した場合' do
      let(:login_user) { user_a }

      before do
        create(:task1, user: user_b)
        visit admin_user_path(user_b)
      end

      it 'そのユーザーの情報とタスクが表示されていること' do
        expect(page).to have_content '管理画面'
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'ユーザーB'
        expect(page).to have_content '植栽1'
      end
    end

    context '任意のユーザー情報を更新した場合' do
      let(:login_user) { user_a }

      before do
        create(:task1, user: user_b)
        visit edit_admin_user_path(user_b)
        fill_in 'メールアドレス', with: 'change@example.com'
        click_on '更新する'
      end

      it 'そのユーザーの更新された情報とタスクが表示されていること' do
        expect(page).to have_content 'ユーザー「ユーザーB」を編集しました'
        expect(page).to have_content '管理画面'
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'change@example.com'
        expect(page).to have_content '植栽1'
      end
    end

    context '任意のユーザーを削除した場合' do
      let(:login_user) { user_a }

      before do
        create(:task1, user: user_b)
        visit admin_users_path
        find(".user-#{user_b.id}").click
        page.driver.browser.switch_to.alert.accept
      end

      it 'そのユーザーが削除されていること' do
        expect(page).to have_content 'ユーザー「ユーザーB」を削除しました'
        expect(page).to have_content '管理画面'
        expect(page).to have_content 'ユーザー 一覧'
      end
    end
  end
end
