require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  # tests layout links by searching across all erb files for html tags with the specified links
  # e.g. checks that the entire website has 2 links to root_path
  test 'layout links' do
    get root_path
    #  the assert_template method verifies that the Home page is rendered using the correct view
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
  end
end
