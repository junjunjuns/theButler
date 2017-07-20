class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/activities
  def index
    # For URL like /groups/1/activities
    # Get the group with id=1
    @group = Group.find(params[:group_id])
    
    # Access all activities for that group
    @activities = @group.activities
  end

  # GET /groups/:group_id/activities/:id
  def show
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/activities/2
    # Find an activity in groups 1 that has id=2
    @activity = @group.activities.find(params[:id])
  end

  # GET /groups/:groups_id/activities/new
  def new
    @group = Group.find(params[:group_id])
    
    # Associate an activity object with group 1
    @activity = @group.activities.build
    
    @activity.group_id = @group.id
  end

  # GET /groups/:group_id/activities/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/activities/2/edit
    # Get activity id=2 for group 1
    @activity = @group.activities.find(params[:id])
  end

  # POST groups/:group_id/activities
  def create
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/activites
    # Populate an activity association with group 1 with form data
    # Group will be associated with the activity
    @activity = @group.activities.build(params.require(:activity).permit!)
    
    @activity.group_id = @group.id

    if @activity.save
      # Save the activity successfully
      redirect_to group_activity_url(@group, @activity)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/activities/:id
  def update
    @group = Group.find(params[:activity][:group_id])
    @activity = Activity.find(params[:id])
    
    if @activity.update_attributes(params.require(:activity).permit!)
      # Update the activity successfully
      redirect_to group_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/activities/:id
  def destroy
    @group = Group.find(params[:group_id])
    @activity.destroy
    
    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Activity was successfully destroyed.' }
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :description, :group_id)
    end
end
