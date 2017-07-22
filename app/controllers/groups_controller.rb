class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end
  
  # GET /groups/home
  def home
    # find the members with profile_id = current_user.id
    #@memberships = Membership.where(:profile_id => current_user.id)
    @memberships = Membership.all
    
    # access all groups that member brlongs to
    @groups = Group.all
  end
    
  # GET /groups/1
  # GET /groups/1.json
  def show
    # Create a new message
    @message = @group.messages.build
    @message.profile_id = current_user.id
    @message.group_id = Group.find(params[:id])
    
    # List all messages for the group
    @messages = Message.all
    
    # List all activities
    @activities = Activity.all
    
    # List all schedules
    @schedules = Schedule.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        # Save creator (the user who created the group) as admin
        @group.memberships.create([ 
          { profile_id: current_user.id, accepted_on: Time.current, g_admin: true }
        ])
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # lists of groups for search
  def search
    @groups = Group.all
    if params[:search] 
      @groups = Group.search(params[:search]).order("name ASC")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
