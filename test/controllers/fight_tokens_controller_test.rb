require 'test_helper'

class FightTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get fight_tokens_new_url
    assert_response :success
  end

  test "should get create" do
    get fight_tokens_create_url
    assert_response :success
  end

end
