require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @sender_email = "nguyen.van.ky@sun-asterisk.com"
  end

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation user
    assert_equal "Account activation email", mail.subject
    assert_equal [user.email], mail.to
    assert_equal [@sender_email], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael)
    user.password_reset_token = User.new_token
    mail = UserMailer.password_reset user
    assert_equal "Reset password email", mail.subject
    assert_equal [user.email], mail.to
    assert_equal [@sender_email], mail.from
    assert_match "password_reset", mail.body.encoded
  end

end
