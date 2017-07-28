require 'test_helper'

class MemberExpensesControllerTest < ActionController::TestCase
  setup do
    @member_expense = member_expenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_expense" do
    assert_difference('MemberExpense.count') do
      post :create, member_expense: { gexpense_id: @member_expense.gexpense_id, membership_id: @member_expense.membership_id, paid: @member_expense.paid }
    end

    assert_redirected_to member_expense_path(assigns(:member_expense))
  end

  test "should show member_expense" do
    get :show, id: @member_expense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member_expense
    assert_response :success
  end

  test "should update member_expense" do
    patch :update, id: @member_expense, member_expense: { gexpense_id: @member_expense.gexpense_id, membership_id: @member_expense.membership_id, paid: @member_expense.paid }
    assert_redirected_to member_expense_path(assigns(:member_expense))
  end

  test "should destroy member_expense" do
    assert_difference('MemberExpense.count', -1) do
      delete :destroy, id: @member_expense
    end

    assert_redirected_to member_expenses_path
  end
end
