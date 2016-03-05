require 'test_helper'

class PregnanciesControllerTest < ActionController::TestCase
  setup do
    @pregnancy = pregnancies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pregnancies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pregnancy" do
    assert_difference('Pregnancy.count') do
      post :create, pregnancy: { ending_at: @pregnancy.ending_at, rabbit_id: @pregnancy.rabbit_id, starting_at: @pregnancy.starting_at }
    end

    assert_redirected_to pregnancy_path(assigns(:pregnancy))
  end

  test "should show pregnancy" do
    get :show, id: @pregnancy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pregnancy
    assert_response :success
  end

  test "should update pregnancy" do
    patch :update, id: @pregnancy, pregnancy: { ending_at: @pregnancy.ending_at, rabbit_id: @pregnancy.rabbit_id, starting_at: @pregnancy.starting_at }
    assert_redirected_to pregnancy_path(assigns(:pregnancy))
  end

  test "should destroy pregnancy" do
    assert_difference('Pregnancy.count', -1) do
      delete :destroy, id: @pregnancy
    end

    assert_redirected_to pregnancies_path
  end
end
