class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /profiles/:profile_id/expenses
  def index
    @profile = Profile.find(params[:profile_id])
    
    @expenses = @profile.expenses
    
    @monthly_exp = @expenses.order('exp_date desc').group_by(&:month)
    
    @cat_exp = @expenses.group_by(&:category).sort
  end
  
  def overview
    @profile = Profile.find(params[:profile_id])
    
    @expenses = @profile.expenses
    
    @monthly_exp = @expenses.order('exp_date').group_by(&:month)
    
    @cat_exp = @expenses.group_by(&:category).sort
  end
  
  # GET /profiles/:profiles_id/expenses/:id
  def show
    @profile = Profile.find(params[:profile_id])
    
    @expense = @profile.expenses.find(params[:id])
  end

  # GET /profiles/:profiles_id/expenses/new
  def new
    @profile = Profile.find(params[:profile_id])
    
    @expense = @profile.expenses.build
    
    @expense.profile_id = current_user.id
    
    @item = Item.where(:category_id => Category.where(:profile_id => (params[:profile_id])))   
    
  end

  # GET /profiles/:profile_id/expenses/:id/edit
  def edit
    @profile = Profile.find(params[:profile_id])
    
    @expense = @profile.expenses.find(params[:id])
    
    @item = Item.where(:category_id => Category.where(:profile_id => (params[:profile_id])))   
  end

  # POST /profiles/:profile_id/expenses
  def create
    @profile = Profile.find(params[:profile_id])
    
    @expense = @profile.expenses.build(params.require(:expense).permit!)
    
    @expense.profile_id = current_user.id
    
    @item = Item.where(:category_id => Category.where(:profile_id => (params[:profile_id])))   
    
    if @expense.save
      redirect_to profile_expenses_url(@profile)
    else
      render :action => "new"
    end

  end

  # PATCH/PUT /profiles/:profile_id/expenses/:id
  def update
    @profile = Profile.find(params[:profile_id])
    @expense = Expense.find(params[:id])
    
    @item = Item.where(:category_id => Category.where(:profile_id => (params[:profile_id])))   
    
    if @expense.update_attributes(params.require(:expense).permit!)
      redirect_to profile_expenses_url(@profile)
    else
      render :action => "edit"
    end
  end

  # DELETE /profiles/:profile_id/expenses/:id
  def destroy
    @profile = Profile.find(params[:profile_id])
    @expense.destroy
    
    respond_to do |format|
      format.html { redirect_to profile_expenses_url(@profile), notice: 'Expense was successfully destroyed.' }
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:exp_date, :amt, :profile_id, :item_id)
    end
end
