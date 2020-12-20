require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    user = { name: '', email: 'foo@invalid',
             password: 'foo', password_confirmation: 'bar' }
    patch user_path(@user), params: { user: user }
    assert_select 'div.field_with_errors', count: 8
    assert_template 'users/edit'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    user = { name: name, email: email, password: '', password_confirmation: '' }
    patch user_path(@user), params: { user: user }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test 'should redirect edit when not logged in ' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    user = { name: name, email: email, password: '', password_confirmation: '' }
    patch user_path(@user), params: { user: user }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
