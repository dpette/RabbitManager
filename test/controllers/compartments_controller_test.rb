require 'test_helper'

class CompartmentsControllerTest < ActionController::TestCase
  setup do
    @compartment = compartments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compartments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compartment" do
    assert_difference('Compartment.count') do
      post :create, compartment: {  }
    end

    assert_redirected_to compartment_path(assigns(:compartment))
  end

  test "should show compartment" do
    get :show, id: @compartment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @compartment
    assert_response :success
  end

  test "should update compartment" do
    patch :update, id: @compartment, compartment: {  }
    assert_redirected_to compartment_path(assigns(:compartment))
  end

  test "should destroy compartment" do
    assert_difference('Compartment.count', -1) do
      delete :destroy, id: @compartment
    end

    assert_redirected_to compartments_path
  end
end
