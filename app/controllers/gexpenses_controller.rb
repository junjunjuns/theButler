class GexpensesController < ApplicationController
  before_action :set_gexpense, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/gexpenses
  def index
    @group = Group.find(params[:group_id])
    
    @gexpenses = @group.gexpenses
    
    @cat_exp = @gexpenses.group_by(&:category).sort
    
    @member_expense = MemberExpense.where(:gexpense_id => @gexpenses.ids)
  end

  # GET /groups/:group_id/gexpenses/:id
  def show
    @group = Group.find(params[:group_id])
    
    @gexpense = @group.gexpenses.find(params[:id])
    
    @member_expense = MemberExpense.where(:gexpense_id => @gexpense.id)
  end

  # GET /groups/:group_id/gexpenses/new
  def new
    @group = Group.find(params[:group_id])
    
    @gexpense = @group.gexpenses.build
    
    @membership = @group.memberships

    @gexpense.profile_id = current_user.id
    @gexpense.group_id = @group.id
    
    @gitem = Gitem.where(:gcategory_id => Gcategory.where(:group_id => (params[:group_id])))
  end

  # GET /groups/:group_id/gexpenses/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    
    @gexpense = @group.gexpenses.find(params[:id])
    
    @membership = @group.memberships
    
    @gexpense.profile_id = current_user.id
    @gexpense.group_id = @group.id
    
    @gitem = Gitem.where(:gcategory_id => Gcategory.where(:group_id => (params[:group_id])))
  end

  # POST /groups/:group_id/gexpenses
  def create
    @group = Group.find(params[:group_id])
    
    @gexpense = @group.gexpenses.build(params.require(:gexpense).permit!)
    
    @membership = @group.memberships
    
    @gexpense.profile_id = current_user.id
    @gexpense.group_id = @group.id
    
    @gitem = Gitem.where(:gcategory_id => Gcategory.where(:group_id => (params[:group_id])))
    
    if @gexpense.save
      redirect_to group_gexpenses_url(@group)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/gexpenses/:id
  def update
    @group = Group.find(params[:group_id])
    @gexpense = Gexpense.find(params[:id])
    
    @membership = @group.memberships.where(:accepted_on.nil?)
    
    @gexpense.profile_id = current_user.id
    @gexpense.group_id = @group.id
    
    @gitem = Gitem.where(:gcategory_id => Gcategory.where(:group_id => (params[:group_id])))
    
    if @gexpense.update_attributes(params.require(:gexpense).permit!)
      redirect_to group_gexpenses_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/gexpenses/:id
  def destroy
    @group = Group.find(params[:group_id])
    @gexpense.destroy
    respond_to do |format|
      format.html { redirect_to group_gexpenses_url(@group), notice: 'Gexpense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def calc_shared
    @group = Group.find(params[:group_id])
    @gexpense = Gexpense.find(params[:id])
    
    @member_expense = @gexpense.member_expenses.count
    
    @shared_amt = @gexpense.total_amt / (@member_expense + 1)
    
    @gexpense.update_attribute(:shared_amt, @shared_amt)
    
    redirect_to request.referer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gexpense
      @gexpense = Gexpense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gexpense_params
      params.require(:gexpense).permit(:paid_on, :total_amt, :shared_amt, :profile_id, :group_id, :gitem_id, membership_ids:[])
    end
end
