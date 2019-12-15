require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    user_a = create(:user)
    visit new_session_path
    fill_in 'メールアドレス', with: 'a@example.com'
    fill_in 'パスワード', with: 'password!'
    click_on 'ログイン'

    @task1 = create(:task1, user: user_a)
    create(:task2, user: user_a)
    create(:task3, user: user_a)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path

        expect(page).to have_content '植栽1'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順で並んでいること' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく(要素にtask_worというクラスをつけておく)

        expect(task_list[0]).to have_content '伐採1'
        expect(task_list[1]).to have_content '植栽2'
      end

      it 'タスクが終了期限の昇順で並んでいること' do
        visit tasks_path
        click_on '終了期限'
        sleep 1 # ソート後の画面表示を待つ -> テストが通らないため
        task_list = all('.task_row')

        expect(task_list[0]).to have_content '植栽1'
        expect(task_list[1]).to have_content '植栽2'
      end
    end

    context 'タスク名「植栽」で検索した場合' do
      it 'タスク名「植栽」を含むタスクが表示されていること' do
        visit tasks_path
        fill_in 'search_name', with: '植栽'
        click_on '実行する'

        expect(page).to have_content '植栽'
      end
    end

    context 'ステータスを「未着手」で検索した場合' do
      it 'ステータス「未着手」のタスクが表示されていること' do
        visit tasks_path
        select '未着手', from: 'search_status'
        click_on '実行する'

        expect(page).to have_content '未着手'
      end
    end

    context 'タスク名「植栽」ステータスを「完了」で検索した場合' do
      it 'タスク名「植栽」を含み、ステータス「完了」のタスクが表示されていること' do
        visit tasks_path
        fill_in 'search_name', with: '植栽'
        select '完了', from: 'search_status'
        click_on '実行する'

        expect(page).to have_content '植栽'
        expect(page).to have_content '完了'
      end
    end

    context 'タスクの優先順位で高い順にソートした場合' do
      it '優先順位が高 -> 中 -> 低の順番で表示されていること' do
        visit tasks_path
        click_on '優先順位'
        sleep 1
        task_list = all('.task_row')

        expect(task_list[0]).to have_content '植栽1'
        expect(task_list[1]).to have_content '植栽2'
        expect(task_list[2]).to have_content '伐採1'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されていること' do
        visit new_task_path
        fill_in '名称', with: 'task_test'
        fill_in '詳しい説明', with: 'タスクの登録テスト'
        select '2019', from: 'task_expired_at_1i'
        select '12', from: 'task_expired_at_2i'
        select '31', from: 'task_expired_at_3i'
        select '17', from: 'task_expired_at_4i'
        select '00', from: 'task_expired_at_5i'
        click_on '登録する'

        expect(page).to have_content 'タスク「task_test」を登録しました'
        expect(page).to have_content 'task_test'
        expect(page).to have_content 'タスクの登録テスト'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit task_path(@task1)

        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'Factoryで作ったタスク1です'
      end
    end
  end
end
