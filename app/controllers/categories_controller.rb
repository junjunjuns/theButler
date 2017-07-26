class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET profiles/:profile_id/categories
  def index
    @profile = Profile.find(params[:profile_id])
    
    @categories = @profile.categories
    
    @items = Item.all
  end

  # GET /profiles/:profile_id/categories/:id
  def show
    @profile = Profile.find(params[:profile_id])
    
    @category = @profile.categories.find(params[:id])
    
    @items = @category.items
  end

  # GET /profiles/:profile_id/categories/new
  def new
    @profile = Profile.find(params[:profile_id])
    
    @category = @profile.categories.build
    
    @category.profile_id = current_user.id
  end

  # GET /profiles/:profile_id/categories/:id/edit
  def edit
    @profile = Profile.find(params[:profile_id])
    
    @category = @profile.categories.find(params[:id])
  end

  # POST /profiles/:profile_id/categories
  def create
    @profile = Profile.find(params[:profile_id])
    
    @category = @profile.categories.build(params.require(:category).permit!)
    
    @category.profile_id = current_user.id
    
    if @category.save
      redirect_to profile_categories_url(@profile)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /profiles/:profile_id/categories/:id
  def update
    @profile = Profile.find(params[:profile_id])
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params.require(:category).permit!)
      redirect_to profile_categories_url(@profile)
    else
      render :action => "edit"
    end
  end

  # DELETE /profiles/:profile_id/categories/:id
  def destroy
    @profile = Profile.find(params[:profile_id])
    @category.destroy
    
    respond_to do |format|
      format.html { redirect_to profile_categories_url(@profile), notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :desc, :profile_id)
    end
end
