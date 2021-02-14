# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @book = create(:book)

    sign_in @user
  end

  test '本の一覧ページが表示されること' do
    visit books_path
    assert_selector 'h1', text: '本'
  end

  test '新たに本を作成できること' do
    visit books_path
    click_on '新規作成'

    fill_in 'タイトル', with: 'そして誰もいなくなった'
    fill_in 'メモ', with: '有名なミステリー小説'
    fill_in '著者', with: 'アガサ・クリスティ'
    click_on '登録する'
    assert_current_path book_path(Book.last)

    assert_text 'そして誰もいなくなった'
    assert_text '有名なミステリー小説'
    assert_text 'アガサ・クリスティ'
    assert_text '本が作成されました。'
  end

  test '本を編集できること' do
    visit books_path
    click_link '編集', href: edit_book_path(@book)

    fill_in 'タイトル', with: 'そして誰もいなくなった'
    fill_in 'メモ', with: '有名なミステリー小説'
    fill_in '著者', with: 'アガサ・クリスティ'
    click_on '更新する'
    assert_current_path book_path(@book)

    assert_text 'そして誰もいなくなった'
    assert_text '有名なミステリー小説'
    assert_text 'アガサ・クリスティ'
    assert_text '本が更新されました。'
  end

  test '本を削除できること' do
    visit books_path
    page.accept_confirm do
      click_link '削除', href: book_path(@book)
    end

    assert_text '本が削除されました。'
    assert_not Book.exists?(@book.id)
  end

  test '本にコメントを追加できること' do
    visit book_path(@book)
    fill_in 'comment_content', with: '面白かったです！'
    click_on 'コメントする'

    assert_text '面白かったです！'
  end
end
