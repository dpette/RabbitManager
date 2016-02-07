require 'test_helper'

class WeaningCagesControllerTest < ActionController::TestCase
  setup do
    @weaning_cage = weaning_cages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weaning_cages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weaning_cage" do
    assert_difference('WeaningCage.count') do
      post :create, weaning_cage: {  }
    end

    assert_redirected_to weaning_cage_path(assigns(:weaning_cage))
  end

  test "should show weaning_cage" do
    get :show, id: @weaning_cage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weaning_cage
    assert_response :success
  end

  test "should update weaning_cage" do
    patch :update, id: @weaning_cage, weaning_cage: {  }
    assert_redirected_to weaning_cage_path(assigns(:weaning_cage))
  end

  test "should destroy weaning_cage" do
    assert_difference('WeaningCage.count', -1) do
      delete :destroy, id: @weaning_cage
    end

    assert_redirected_to weaning_cages_path
  end
end
