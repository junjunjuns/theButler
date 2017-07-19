class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /groups/:group_id/messages
  def index
    # For URL like /groups/1/messages
    # Get the group with id=1
    @group = Group.find(params[:group_id])
    
    # Access all messages for that group
    @messages = @group.messages
  end

  # GET /groups/:group_id/messages/:id
  def show
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/messages/2
    # Find a message in groups 1 that has id=2
    @message = @group.messages.find(params[:id])
  end

  # GET /groups/:groups_id/messages/new
  def new
    @group = Group.find(params[:group_id])
    
    # Associate a message object with group 1
    @message = @group.messages.build
    
    # Set profile_id to current_user_id
    @message.profile_id = current_user.id
  end

  # GET /groups/:group_id/messages/:id/edit
  def edit
    @group = Group.find(params[:group_id])
    
    # For URL like /groups/1/messages/2/edit
    # Get message id=2 for group 1
    @message = @group.messages.find(params[:id])
  end

  # POST groups/:group_id/messages
  def create
    @group = Group.find(params[:group_id])
    @membership = Membership.where(:profile_id => current_user.id)
    
    # For URL like /groups/1/messages
    # Populate a message association with group 1 with form data
    # Group will be associated with the message
    @message = @group.messages.build(params.require(:message).permit!)
    
    @message.profile_id = current_user.id
    @message.group_id = @group.id

    if @message.save
      # Save the message successfully
      redirect_to group_url(@group)
    else
      render :action => "new"
    end
  end

  # PATCH/PUT /groups/:group_id/messages/:id
  def update
    @group = Group.find(params[:group_id])

    @message = Message.find(params[:id])
    
    if @message.update_attributes(params.require(:message).permit!)
      # Save the message successfully
      redirect_to group_url(@group)
    else
      render :action => "edit"
    end
  end

  # DELETE /groups/:group_id/messages/:id
  def destroy
    @group = Group.find(params[:group_id])
    @membership = Membership.find(:profile_id => current_user.id)
    @message = Message.find(params[:id])
    @message.destroy
    
    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Message was successfully destroyed.' }
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :group_id, :profile_id)
    end
end
