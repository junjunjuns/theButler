class MemberExpensesController < ApplicationController
  before_action :set_member_expense, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/gexpenses/:gexpense_id/member_expenses
  def index
    @group = Group.find(params[:group_id])
    @gexpense = @group.gexpenses.find(params[:gexpense_id])
    
    @member_expenses = @gexpense.member_expenses
  end

  # GET /groups/:group_id/gexpenses/:gexpense_id/member_expenses/:id
  def show
    @group = Group.find(params[:group_id])
    @gexpense = @group.gexpenses.find(params[:gexpense_id])
    @member_expense = @gexpense.member_expenses.find(params[:id])
  end

  # GET /groups/:group_id/gexpenses/:gexpense_id/member_expenses/new
  def new
    @group = Group.find(params[:group_id])
    @gexpense = @group.gexpenses.find(params[:gexpense_id])
    
    @member_expense = @gexpense.member_expenses.build
    
    @member_expesnse.gexpense_id = @gexpense.id
  end

  # GET /groups/:group_id/gexpenses/:gexpense_id/member_expenses/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    @gexpense = @group.gexpenses.find(params[:gexpense_id])
    
    @member_expense = @gexpense.member_expenses.find(params[:id])
    
    @member_expesnse.gexpense_id = @gexpense.id
  end

  # POST /groups/:group_id/gexpenses/:gexpense_id/member_expenses
  def create
    @group = Group.find(params[:group_id])
    @gexpense = @group.gexpenses.find(params[:gexpense_id])
    
    @member_expense = @gexpense.member_expenses.build(params.require(:member_expense).permit!)

    @member_expense.gexpense_id = @gexpense.id

    if @member_expense.save
      redirect_to group_gexpenses_url(@group)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/gexpenses/:gexpense_id/member_expenses/:id
  def update
    @group = Group.find(params[:group_id])
    @gexpense = Gexpense.find(params[:gexpense_id])
    @member_expense = MemberExpense.find(params[:id])

    @member_expesnse.gexpense_id = @gexpense.id

    if @member_expense.update_attributes(params.require(:member_expense).permit!)
      redirect_to group_gexpenses_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/gexpenses/:gexpense_id/member_expenses/:id
  def destroy
    @group = Group.find(params[:group_id])
    @gexpense = Gexpense.find(params[:gexpense_id])
    
    @member_expense.destroy
    respond_to do |format|
      format.html { redirect_to group_gexpenses_url(@group), notice: 'Member expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # pay for an expense
  def pay
    @group = Group.find(params[:group_id])
    @gexpense = Gexpense.find(params[:gexpense_id])
    @member_expense = MemberExpense.find(params[:id])

    @member_expense.update_attribute(:paid, true)
    
    redirect_to request.referer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_expense
      @member_expense = MemberExpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_expense_params
      params.require(:member_expense).permit(:paid, :membership_id, :gexpense_id)
    end
end
