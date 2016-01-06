require 'test_helper'

class RabbitsControllerTest < ActionController::TestCase
  setup do
    @rabbit = rabbits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rabbits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rabbit" do
    assert_difference('Rabbit.count') do
      post :create, rabbit: {  }
    end

    assert_redirected_to rabbit_path(assigns(:rabbit))
  end

  test "should show rabbit" do
    get :show, id: @rabbit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rabbit
    assert_response :success
  end

  test "should update rabbit" do
    patch :update, id: @rabbit, rabbit: {  }
    assert_redirected_to rabbit_path(assigns(:rabbit))
  end

  test "should destroy rabbit" do
    assert_difference('Rabbit.count', -1) do
      delete :destroy, id: @rabbit
    end

    assert_redirected_to rabbits_path
  end
end
