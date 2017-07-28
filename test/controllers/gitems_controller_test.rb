require 'test_helper'

class GitemsControllerTest < ActionController::TestCase
  setup do
    @gitem = gitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gitem" do
    assert_difference('Gitem.count') do
      post :create, gitem: { desc: @gitem.desc, gcategory_id: @gitem.gcategory_id, name: @gitem.name }
    end

    assert_redirected_to gitem_path(assigns(:gitem))
  end

  test "should show gitem" do
    get :show, id: @gitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gitem
    assert_response :success
  end

  test "should update gitem" do
    patch :update, id: @gitem, gitem: { desc: @gitem.desc, gcategory_id: @gitem.gcategory_id, name: @gitem.name }
    assert_redirected_to gitem_path(assigns(:gitem))
  end

  test "should destroy gitem" do
    assert_difference('Gitem.count', -1) do
      delete :destroy, id: @gitem
    end

    assert_redirected_to gitems_path
  end
end
