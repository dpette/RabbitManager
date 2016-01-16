require 'test_helper'

class FatteningsControllerTest < ActionController::TestCase
  setup do
    @fattening = fattenings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fattenings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fattening" do
    assert_difference('Fattening.count') do
      post :create, fattening: {  }
    end

    assert_redirected_to fattening_path(assigns(:fattening))
  end

  test "should show fattening" do
    get :show, id: @fattening
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fattening
    assert_response :success
  end

  test "should update fattening" do
    patch :update, id: @fattening, fattening: {  }
    assert_redirected_to fattening_path(assigns(:fattening))
  end

  test "should destroy fattening" do
    assert_difference('Fattening.count', -1) do
      delete :destroy, id: @fattening
    end

    assert_redirected_to fattenings_path
  end
end
