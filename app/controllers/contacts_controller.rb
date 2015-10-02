class ContactsController < ApplicationController







    def index
      set_group
      @contacts = Group.find(@group).contacts
    end

    def show
      set_group
      #set_contact
      @contact = get_contact
    end

    def new
      set_group
      @contact = Contact.new
    end

    def create
      set_group
      @contact = Contact.new(contact_params)
      @contact.group = @group
      if @contact.save
        redirect_to group_contacts_path(@group, @contact)
      else
        render 'new'
      end
    end


    def edit
      set_group
      #set_contact
      @contact = get_contact
    end

    def update
      set_group
      #set_contact
      @contact = get_contact
      if @contact.update(contact_params)
        redirect_to group_contacts_path(@group, @contact)
      else
        render 'edit'
      end
    end

    def destroy
      set_group
      #set_contact
      @contact = get_contact
      @contact.destroy
      redirect_to group_contacts_path(@group)
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


end
