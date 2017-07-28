class GitemsController < ApplicationController
  before_action :set_gitem, only: [:show, :edit, :update, :destroy]

  # GET groups/:group_id/gcategories/:gcategory_id/gitems
  def index
    @group = Group.find(params[:group_id])
    @gcategory = @group.gcategories.find(params[:gcategory_id])
    
    @gitems = @gcategory.gitems
  end

  # GET groups/:group_id/gcategories/:gcategory_id/gitems/:id
  def show
    @group = Group.find(params[:group_id])
    @gcategory = @group.gcategories.find(params[:gcategory_id])
    
    @gitem = @gcategory.gitems.find(params[:id])
  end

  # GET groups/:group_id/gcategories/:gcategory_id/gitems/new
  def new
    @group = Group.find(params[:group_id])
    @gcategory = @group.gcategories.find(params[:gcategory_id])
    
    @gitem = @gcategory.gitems.build
    @gcategories = @group.gcategories
  end

  # GET groups/:group_id/gcategories/:gcategory_id/gitems/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    @gcategory = @group.gcategories.find(params[:gcategory_id])
    
    @gitem = @gcategory.gitems.find(params[:id])
    @gcategories = @group.gcategories
  end

  # POST groups/:group_id/gcategories/:gcategory_id/gitems
  def create
    @group = Group.find(params[:group_id])
    @gcategory = @group.gcategories.find(params[:gcategory_id])
    
    @gitem = @gcategory.gitems.build(params.require(:gitem).permit!)
    @gcategories = @group.gcategories
    
    if @gitem.save
      redirect_to group_gcategories_url(@group)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT groups/:group_id/gcategories/:gcategory_id/gitems/1
  def update
    @group = Group.find(params[:group_id])
    @gcategory = Gcategory.find(params[:gcategory_id])
    @gitem = Gitem.find(params[:id])
    
    @gcategories = @group.gcategories
    
    if @gitem.update_attributes(params.require(:gitem).permit!)
      redirect_to group_gcategories_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE groups/:group_id/gcategories/:gcategory_id/gitems/1
  def destroy
    @group = Group.find(params[:group_id])
    @gcategory = Gcategory.find(params[:gcategory_id])
    
    @gitem.destroy
    respond_to do |format|
      format.html { redirect_to group_gcategories_url(@group), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gitem
      @gitem = Gitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gitem_params
      params.require(:gitem).permit(:name, :desc, :gcategory_id)
    end
end
