class ContactsController < ApplicationController







    def index
      if current_user
        set_user
        set_group
        @contacts = Group.find(@group).contacts
      else new_user
        redirect_to root_path
      end
    end

    def show
      if current_user
        set_user
        set_group
        #set_contact
        @contact = get_contact
      else new_user
        redirect_to root_path
      end
    end

    def new
      if current_user
        set_user
        set_group
        @contact = Contact.new
      else new_user
        redirect_to root_path
      end
    end

    def create
      if current_user
        set_user
        set_group
        @contact = Contact.new(contact_params)
        binding.pry
        @contact.user = @user
        @contact.group = @group
        if @contact.save
          redirect_to user_group_contacts_path(@group, @contact)
        else
          render 'new'
        end
      else new_user
        redirect_to root_path
      end
    end


    def edit
      set_user
      set_group
      #set_contact
      @contact = get_contact
    end

    def update
      set_user
      set_group
      #set_contact
      @contact = get_contact
      if @contact.update(contact_params)
        redirect_to user_group_contacts_path(@group, @contact)
      else
        render 'edit'
      end
    end

    def destroy
      set_user
      set_group
      #set_contact
      @contact = get_contact
      @contact.destroy
      redirect_to user_group_contacts_path(@group)
    end




    private

      def contact_params
        params.require(:contact).permit(:name, :phone_number, :group_id)
      end

      def get_contact
        Contact.find(params[:id])
      end

      def set_contact
        @contact = Contact.find(params[:contact_id])
      end

      def set_group
        @group = Group.find(params[:group_id])
      end

      def set_user
        @user = User.find(session[:user_id])
      end

end
