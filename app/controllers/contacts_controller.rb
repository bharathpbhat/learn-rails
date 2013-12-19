class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?
      #TODO: Save date
      #TODO: Send message
      @contact.update_spreadsheet
      flash[:notice] = "Message sent from #{@contact.name}"
      UserMailer.contact_email(@contact).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def secure_params
    params.require(:contact).permit(:name, :email,:content)
  end
end
