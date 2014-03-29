require 'test_helper'

class CourseRatingsControllerTest < ActionController::TestCase
  setup do
    @course_rating = course_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_rating" do
    assert_difference('CourseRating.count') do
      post :create, course_rating: { name: @course_rating.name, score: @course_rating.score }
    end

    assert_redirected_to course_rating_path(assigns(:course_rating))
  end

  test "should show course_rating" do
    get :show, id: @course_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_rating
    assert_response :success
  end

  test "should update course_rating" do
    put :update, id: @course_rating, course_rating: { name: @course_rating.name, score: @course_rating.score }
    assert_redirected_to course_rating_path(assigns(:course_rating))
  end

  test "should destroy course_rating" do
    assert_difference('CourseRating.count', -1) do
      delete :destroy, id: @course_rating
    end

    assert_redirected_to course_ratings_path
  end
end
