require 'test_helper'

class CrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get crews_new_url
    assert_response :success
  end

  test "should get create" do
    get crews_create_url
    assert_response :success
  end

  test "should get show" do
    get crews_show_url
    assert_response :success
  end

end
