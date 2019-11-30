require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'descriptionが空なら、バリデーションが通らない' do
    task = Task.new(name: '失敗テスト', description: '')
    expect(task).not_to be_valid
  end

  it 'nameとdescriptionに内容が記載されていれば、バリデーションが通る' do
    task = Task.new(name: '成功テスト', description: 'テストが成功しました！')
    expect(task).to be_valid
  end

  it 'nameが30文字より大きければ、バリデーションが通らない' do
    task = Task.new(name: 'a' * 31, description: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'nameが重複していたら、バリデーションが通らない' do
    Task.create(name: 'タスク1', description: 'タスク1です' )
    task = Task.new(name: 'タスク1', description: 'タスク名称の重複は認められません')
    expect(task).not_to be_valid
  end
end
