class GroupsController < ApplicationController

    def index
      @groups = Group.all
    end

    def show
      @group = get_group
      @messages = get_group.messages
    end

    def new
      @group = Group.new
    end

    def create
      @group = Group.new(group_params)
      if @group.save
        redirect_to @group
      else
        render 'new'
      end
    end

    def edit
      @group = get_group
    end

    def update
      @group = get_group
      if @group.update(group_params)
        redirect_to group_messages_path(@group)
      else
        render 'edit'
      end
    end

    def destroy
      @group = get_group
      @group.destroy
      redirect_to groups_path
    end



    private

      def group_params
        params.require(:group).permit(:name, :description, :image_url)
      end

      def get_group
        Group.find(params[:id])
      end


  end
