require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    get users_path
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)

    assert_template 'users/index'
    assert_select 'div.pagination'
    # debugger
    users=assigns(:users)
    users.each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end  

  # test 'index include pagination' do
  #   log_in_as(@user)
  #   debugger
  #   get users_path
  #   assert_template 'users/index'
  #   assert_select 'div.pagination'
  #   User.paginate(page: 1).each do |user|
  #     assert_select 'a[href=?]', user_path(user), text: user.name
  #   end
  # end
end
