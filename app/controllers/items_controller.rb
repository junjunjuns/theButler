class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /profiles/:profile_id/categories/:category_id/items
  def index
    @profile = Profile.find(params[:profile_id])
    @category = @profile.categories.find(params[:category_id])
    
    @items = @category.items
  end

  # GET /profiles/:profile_id/categories/:category_id/items/:id
  def show
    @profile = Profile.find(params[:profile_id])
    @category = @profile.categories.find(params[:category_id])
    @item = @category.items.find(params[:id])
  end

  # GET /profiles/:profile_id/categories/:category_id/items/new
  def new
    @profile = Profile.find(params[:profile_id])
    @category = @profile.categories.find(params[:category_id])
    
    @item = @category.items.build
    @categories = @profile.categories
  end

  # GET /profiles/:profile_id/categories/:category_id/items/:id/edit
  def edit
    @profile = Profile.find(params[:profile_id])
    @category = @profile.categories.find(params[:category_id])
    
    @item = @category.items.find(params[:id])
    @categories = @profile.categories
  end

  # POST profiles/:profile/categories/:category_id/items
  def create
    @profile = Profile.find(params[:profile_id])
    @category = @profile.categories.find(params[:category_id])
    
    @item = @category.items.build(params.require(:item).permit!)
    @categories = @profile.categories
    
    if @item.save
      redirect_to profile_categories_url(@profile)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /profiles/:profile_id/categories/:category_id/items/:id
  def update
    @profile = Profile.find(params[:profile_id])
    @category = Category.find(params[:category_id])
    @item = Item.find(params[:id])
    
    @categories = @profile.categories
    
    if @item.update_attributes(params.require(:item).permit!)
      redirect_to profile_categories_url(@profile)
    else
      render :action => "edit"
    end
  end

  # DELETE /profiles/:profile_id/categories/:category_id/items/:id
  def destroy
    @profile = Profile.find(params[:profile_id])
    @category = Category.find(params[:category_id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to profile_categories_url(@profile), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :desc, :category_id)
    end
end
