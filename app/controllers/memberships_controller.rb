class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/memberships
  def index
    # For URL like /groups/1/memberships
    # Get the group with id=1
    @group = Group.find(params[:group_id])
    
    # Access all memberhips for that group
    @memberships = @group.memberships
    
    # check if user is admin
    @user = @memberships.find_by_profile_id(current_user.id)
    if @user.g_admin == true
      @admin = true
    else
      @admin = false
    end
  end

  # GET /groups/:group_id/memberships/:id
  def show
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/memberships/2
    # Find a membership in groups 1 that has id=2
    @membership = @group.memberships.find(params[:id])
  end

  # GET /groups/:groups_id/memberships/new
  def new
    @group = Group.find(params[:group_id])
    
    # Associate a membership object with group 1
    @membership = @group.memberships.build
    
    # Set profile_id to current_user.id
    # profile_id = current_user.id (one user can only have one profile, each user create profile as they register)
    @membership.profile_id = current_user.id
  end

  # GET /groups/:group_id/memberships/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/memberships/2/edit
    # Get membership id=2 for group 1
    @membership = @group.memberships.find(params[:id])
  end

  # POST groups/:group_id/memberships
  def create
    @group = Group.find(params[:membership][:group_id])
    
    # For URL like /groups/1/memberships
    # Populate a membership association with group 1 with form data
    # Group will be associated with the membership
    @membership = @group.memberships.build(params.require(:membership).permit!)
    #@membership = @group.membership.build(params.require(:membership).permit(:user_id, :group_id, :admin, :accepted_on)))
    
    if @membership.save
      # Save the membership successfully
      redirect_to group_membership_url(@group, @membership)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/memberships/:id
  def update
    @group = Group.find(params[:membership][:group_id])
    @membership = Membership.find(params[:id])
    
    if @membership.update_attributes(params.require(:membership).permit!)
      # Save the membership successfully
      redirect_to group_membership_url(@group, @membership)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/memberships/:id
  def destroy
    @group = Group.find(params[:group_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    
    respond_to do |format|
      format.html { redirect_to group_memberships_url(@group), notice: 'Membership was successfully destroyed.' }
      format.xml { head :ok }
    end
  end
  
  # request to join group
  def join
    @group = Group.find(params[:group_id])

    @membership = @group.memberships.build
    
    @membership.profile_id = current_user.id
    @membership.group_id = @group.id

    if @membership.save
      # Save the membership successfully
      redirect_to group_home_url(@group, @membership)
    else
      render :action => "new"
    end
  end

  # accept member
  def accept
    @@group = Group.find(params[:membership][:group_id])
    @membership = Membership.find(params[:id])
    
    @membership.update_attributes(:accepted_on, Time.current)
    
    redirect_to @membership
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:accepted_on, :g_admin, :profile_id, :group_id)
    end
end
