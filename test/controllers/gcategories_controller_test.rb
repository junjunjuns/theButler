require 'test_helper'

class GcategoriesControllerTest < ActionController::TestCase
  setup do
    @gcategory = gcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gcategory" do
    assert_difference('Gcategory.count') do
      post :create, gcategory: { desc: @gcategory.desc, group_id: @gcategory.group_id, name: @gcategory.name }
    end

    assert_redirected_to gcategory_path(assigns(:gcategory))
  end

  test "should show gcategory" do
    get :show, id: @gcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gcategory
    assert_response :success
  end

  test "should update gcategory" do
    patch :update, id: @gcategory, gcategory: { desc: @gcategory.desc, group_id: @gcategory.group_id, name: @gcategory.name }
    assert_redirected_to gcategory_path(assigns(:gcategory))
  end

  test "should destroy gcategory" do
    assert_difference('Gcategory.count', -1) do
      delete :destroy, id: @gcategory
    end

    assert_redirected_to gcategories_path
  end
end
