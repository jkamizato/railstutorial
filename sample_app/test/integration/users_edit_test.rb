require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:julio)
    log_in_as @user
  end

  test 'should get the new' do
    get new_user_url
    assert_response :success
  end

  test'unsuccessful edit' do
    get edit_user_path (@user)
    assert_template 'users/edit'
    patch user_path (@user), user: {
                        name: " ",
                        email: "foo@invalid.com",
                        password: "foo",
                        password_validation: "bar"

                           }
    assert_template 'users/edit'
  end

  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  # test "successful edit with friendly forwarding" do
  #   get edit_user_path(@user)
  #   assert_template 'users/edit'
  #   #assert_redirected_to login_url
  #   log_in_as(@user)
  #   assert_redirected_to edit_user_path(@user)
  #   name  = "Foo Bar"
  #   email = "foo@bar.com"
  #   patch user_path(@user), user: { name:  name,
  #                                   email: email,
  #                                   password:              "",
  #                                   password_confirmation: "" }
  #   assert_not flash.empty?
  #   assert_redirected_to @user
  #   @user.reload
  #   assert_equal name,  @user.name
  #   assert_equal email, @user.email
  # end

end
