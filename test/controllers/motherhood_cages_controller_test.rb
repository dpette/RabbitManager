require 'test_helper'

class MotherhoodCagesControllerTest < ActionController::TestCase
  setup do
    @motherhood_cage = motherhood_cages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:motherhood_cages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create motherhood_cage" do
    assert_difference('MotherhoodCage.count') do
      post :create, motherhood_cage: {  }
    end

    assert_redirected_to motherhood_cage_path(assigns(:motherhood_cage))
  end

  test "should show motherhood_cage" do
    get :show, id: @motherhood_cage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @motherhood_cage
    assert_response :success
  end

  test "should update motherhood_cage" do
    patch :update, id: @motherhood_cage, motherhood_cage: {  }
    assert_redirected_to motherhood_cage_path(assigns(:motherhood_cage))
  end

  test "should destroy motherhood_cage" do
    assert_difference('MotherhoodCage.count', -1) do
      delete :destroy, id: @motherhood_cage
    end

    assert_redirected_to motherhood_cages_path
  end
end
