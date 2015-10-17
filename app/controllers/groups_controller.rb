class GroupsController < ApplicationController

    def index
      if current_user
        set_user
        @groups = User.find(@user).groups
      else new_user
        redirect_to root_path
      end
    end

    def show
      set_user
      @group = get_group
      @messages = get_group.messages
      @contacts = get_group.contacts
    end

    def new
      if current_user
        set_user
        @group = Group.new
      else new_user
        redirect_to root_path
      end
    end

    def create
      if current_user
        set_user
        @group = Group.new(group_params)
        @group.user = @user
        if @group.save
          redirect_to user_groups_path(@user)
        else
          render 'new'
        end
      else new_user
        redirect_to root_path
      end
    end


    def edit
      set_user
      @group = get_group
    end

    def update
      set_user
      @group = get_group
      if @group.update(group_params)
        redirect_to user_groups_path(@user)
      else
        render 'edit'
      end
    end

    def destroy
      set_user
      @group = get_group
      @group.destroy
      redirect_to user_groups_path(@user)
    end



    private

      def group_params
        params.require(:group).permit(:name, :description, :image_url, :group_id, :user_id)
      end

      def get_group
        Group.find(params[:id])
      end

      def set_user
        @user = User.find(session[:user_id])
      end


  end
