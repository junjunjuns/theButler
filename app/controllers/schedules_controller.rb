class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/activities/:activity_id/schedules
  def index
    # For URL like /groups/1/activities/2/schedules
    # Get the group with id=1
    @group = Group.find(params[:group_id])
    @activity = @group.activities.find(params[:activity_id])
    
    # Access all schedules for that activity
    @schedules = @activity.schedules
  end

  # GET /groups/:group_id/activities/:activity_id/schedules/:id
  def show
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/activities/2/schedules/3
    # Find a activity in groups 1 that has id=2
    @activity = @group.activities.find(params[:activity_id])
    
    # Find the schedule that has id=3
    @schedule = @activity.schedules.find(params[:id])
  end

  # GET /groups/:groups_id/activities/:activity_id/schedules/new
  def new
    @group = Group.find(params[:group_id])
    @activity = @group.activities.find(params[:activity_id])
    
    # Associate a schedule object with group 1, activity 2
    @schedule = @activity.schedules.build
  end

  # GET /groups/:group_id/activities/:activity_id/schedules/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    @activity = @group.activities.find(params[:activity_id])
    
    # For URL like /groups/1/activities/2/schedules/3/edit
    # Get schedules id=3 for group 1, activity 2
    @schedule = @activity.schedules.find(params[:id])
  end

  # POST groups/:group_id/activities/:activity_id/schedules
  def create
    @group = Group.find(params[:group_id])
    @activity = @group.activities.find(params[:activity_id])
    
    # For URL like /groups/1/activites/2/schedules
    # Populate a schedule association with group 1 , activity 2 with form data
    # schedules will be associated with the activity and group
    @schedule = @activity.schedules.build(params.require(:schedule).permit!)
    
    @schedule.activity_id = @activity.id

    if @schedule.save
      # Save the schedule successfully
      redirect_to group_activity_url(@group, @activity)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/activities/:activity_id/:schedules/:id
  def update
    @group = Group.find(params[:group_id])
    @activity = Activity.find(params[:activity_id])
    @schedule = Schedule.find(params[:id])
    
    if @schedule.update_attributes(params.require(:schedule).permit!)
      # Update the schedule successfully
      redirect_to group_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/activities/:activity_id/schedules/:id
  def destroy
    @group = Group.find(params[:group_id])
    @activity = Activity.find(params[:activity_id])
    @schedule.destroy
    
    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Schedule was successfully destroyed.' }
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:day, :date, :start_time, :activity_id, :membership_id)
    end
end
