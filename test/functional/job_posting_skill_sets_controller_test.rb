require 'test_helper'

class JobPostingSkillSetsControllerTest < ActionController::TestCase
  setup do
    @job_posting_skill_set = job_posting_skill_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_posting_skill_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_posting_skill_set" do
    assert_difference('JobPostingSkillSet.count') do
      post :create, job_posting_skill_set: { job_id: @job_posting_skill_set.job_id, name: @job_posting_skill_set.name }
    end

    assert_redirected_to job_posting_skill_set_path(assigns(:job_posting_skill_set))
  end

  test "should show job_posting_skill_set" do
    get :show, id: @job_posting_skill_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_posting_skill_set
    assert_response :success
  end

  test "should update job_posting_skill_set" do
    put :update, id: @job_posting_skill_set, job_posting_skill_set: { job_id: @job_posting_skill_set.job_id, name: @job_posting_skill_set.name }
    assert_redirected_to job_posting_skill_set_path(assigns(:job_posting_skill_set))
  end

  test "should destroy job_posting_skill_set" do
    assert_difference('JobPostingSkillSet.count', -1) do
      delete :destroy, id: @job_posting_skill_set
    end

    assert_redirected_to job_posting_skill_sets_path
  end
end
