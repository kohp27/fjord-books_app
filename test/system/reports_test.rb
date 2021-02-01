# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user1 = create(:user)
    @user2 = create(:user)
    @my_report = create(:report, user: @user1)
    @other_report = create(:report, user: @user2)

    sign_in @user1
  end

  test '日報の一覧ページが表示されること' do
    visit reports_path
    assert_selector 'h1', text: '日報'
  end

  test '新たに日報を作成できること' do
    visit reports_path
    click_on '新規作成'

    fill_in 'タイトル', with: '課題をクリアしました'
    fill_in '内容', with: 'よかった！'
    click_on '登録する'
    assert_current_path report_path(Report.last)

    assert_text '課題をクリアしました'
    assert_text 'よかった！'
    assert_text '日報が作成されました。'
  end

  test '自分が書いた日報を編集できること' do
    visit reports_path
    click_link '編集', href: edit_report_path(@my_report)

    fill_in 'タイトル', with: '課題をクリアしました'
    fill_in '内容', with: 'よかった！'
    click_on '更新する'
    assert_current_path report_path(@my_report)

    assert_text '課題をクリアしました'
    assert_text 'よかった！'
    assert_text '日報が更新されました。'
  end

  test '他人が書いた日報に編集リンクがないこと' do
    visit reports_path
    assert_no_selector %(a[href="#{report_path(@my_report)}"]), text: '編集'
  end

  test '自分が書いた日報を削除できること' do
    visit reports_path
    page.accept_confirm do
      click_link '削除', href: report_path(@my_report)
    end

    assert_text '日報が削除されました。'
  end

  test '他人が書いた日報に削除リンクがないこと' do
    visit reports_path
    assert_no_selector %(a[href="#{report_path(@other_report)}"]), text: '削除'
  end
end
