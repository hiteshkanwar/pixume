require 'test_helper'

class SchoolRatingsControllerTest < ActionController::TestCase
  setup do
    @school_rating = school_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_rating" do
    assert_difference('SchoolRating.count') do
      post :create, school_rating: { name: @school_rating.name, score: @school_rating.score }
    end

    assert_redirected_to school_rating_path(assigns(:school_rating))
  end

  test "should show school_rating" do
    get :show, id: @school_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_rating
    assert_response :success
  end

  test "should update school_rating" do
    put :update, id: @school_rating, school_rating: { name: @school_rating.name, score: @school_rating.score }
    assert_redirected_to school_rating_path(assigns(:school_rating))
  end

  test "should destroy school_rating" do
    assert_difference('SchoolRating.count', -1) do
      delete :destroy, id: @school_rating
    end

    assert_redirected_to school_ratings_path
  end
end
