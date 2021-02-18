# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?: 対象のユーザーが日報を編集可能かを返すこと' do
    user = create(:user)
    report = create(:report, user_id: user.id)
    assert report.editable?(user)

    other_user = create(:user)
    assert_not report.editable?(other_user)
  end

  test '#created_on: 日報を作成した日付を返すこと' do
    time = Time.current
    report = create(:report, created_at: time)
    assert_equal time.to_date, report.created_on
  end
end
