class GcategoriesController < ApplicationController
  before_action :set_gcategory, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/gcategories
  def index
    @group = Group.find(params[:group_id])
    
    @gcategories = @group.gcategories
    
    @gitems = Gitem.all
  end

  # GET /groups/:group_id/gcategories/:id
  def show
    @group = Group.find(params[:group_id])
    
    @gcategory = @group.gcategories.find(params[:id])
    
    @gitems = @gcategory.gitems
  end

  # GET /groups/:group_id/gcategories/new
  def new
    @group = Group.find(params[:group_id])
    
    @gcategory = @group.gcategories.build
    
    @gcategory.group_id = @group.id
  end

  # GET /groups/:group_id/gcategories/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    
    @gcategory = @group.gcategories.find(params[:id])
  end

  # POST /groups/:group_id/gcategories
  def create
    @group = Group.find(params[:group_id])
    
    @gcategory = @group.gcategories.build(params.require(:gcategory).permit!)
    
    @gcategory.group_id = @group.id
    
    if @gcategory.save
      redirect_to group_gcategories_url(@group)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT groups/:group_id/gcategories/:id
  def update
    @group = Group.find(params[:group_id])
    @gcategory = Gcategory.find(params[:id])
    
    if @gcategory.update_attributes(params.require(:gcategory).permit!)
      redirect_to group_gcategories_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/gcategories/:id
  def destroy
    @group = Group.find(params[:group_id])
    @gcategory.destroy
    
    respond_to do |format|
      format.html { redirect_to group_gcategories_url(@group), notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gcategory
      @gcategory = Gcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gcategory_params
      params.require(:gcategory).permit(:name, :desc, :group_id)
    end
end
