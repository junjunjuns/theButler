require 'test_helper'

class GexpensesControllerTest < ActionController::TestCase
  setup do
    @gexpense = gexpenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gexpenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gexpense" do
    assert_difference('Gexpense.count') do
      post :create, gexpense: { gitem_id: @gexpense.gitem_id, group_id: @gexpense.group_id, paid_on: @gexpense.paid_on, profile_id: @gexpense.profile_id, shared_amt: @gexpense.shared_amt, total_amt: @gexpense.total_amt }
    end

    assert_redirected_to gexpense_path(assigns(:gexpense))
  end

  test "should show gexpense" do
    get :show, id: @gexpense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gexpense
    assert_response :success
  end

  test "should update gexpense" do
    patch :update, id: @gexpense, gexpense: { gitem_id: @gexpense.gitem_id, group_id: @gexpense.group_id, paid_on: @gexpense.paid_on, profile_id: @gexpense.profile_id, shared_amt: @gexpense.shared_amt, total_amt: @gexpense.total_amt }
    assert_redirected_to gexpense_path(assigns(:gexpense))
  end

  test "should destroy gexpense" do
    assert_difference('Gexpense.count', -1) do
      delete :destroy, id: @gexpense
    end

    assert_redirected_to gexpenses_path
  end
end
