require 'test_helper'

class RaceCagesControllerTest < ActionController::TestCase
  setup do
    @race_cage = race_cages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:race_cages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race_cage" do
    assert_difference('RaceCage.count') do
      post :create, race_cage: {  }
    end

    assert_redirected_to race_cage_path(assigns(:race_cage))
  end

  test "should show race_cage" do
    get :show, id: @race_cage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race_cage
    assert_response :success
  end

  test "should update race_cage" do
    patch :update, id: @race_cage, race_cage: {  }
    assert_redirected_to race_cage_path(assigns(:race_cage))
  end

  test "should destroy race_cage" do
    assert_difference('RaceCage.count', -1) do
      delete :destroy, id: @race_cage
    end

    assert_redirected_to race_cages_path
  end
end
