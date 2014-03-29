require 'test_helper'

class UsageTrackingsControllerTest < ActionController::TestCase
  setup do
    @usage_tracking = usage_trackings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usage_trackings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usage_tracking" do
    assert_difference('UsageTracking.count') do
      post :create, usage_tracking: { last_access_url: @usage_tracking.last_access_url, session_id: @usage_tracking.session_id, user_email: @usage_tracking.user_email, user_name: @usage_tracking.user_name }
    end

    assert_redirected_to usage_tracking_path(assigns(:usage_tracking))
  end

  test "should show usage_tracking" do
    get :show, id: @usage_tracking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usage_tracking
    assert_response :success
  end

  test "should update usage_tracking" do
    put :update, id: @usage_tracking, usage_tracking: { last_access_url: @usage_tracking.last_access_url, session_id: @usage_tracking.session_id, user_email: @usage_tracking.user_email, user_name: @usage_tracking.user_name }
    assert_redirected_to usage_tracking_path(assigns(:usage_tracking))
  end

  test "should destroy usage_tracking" do
    assert_difference('UsageTracking.count', -1) do
      delete :destroy, id: @usage_tracking
    end

    assert_redirected_to usage_trackings_path
  end
end
