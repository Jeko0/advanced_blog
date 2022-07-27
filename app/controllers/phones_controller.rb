class PhonesController < ApplicationController
  decorates_assigned :phones, :phone

  def new
    @phone = Phone.new()
  end

  def create
    if valid_mobile?
      current_user.phones.create(phone_params)
      redirect_to user_profile_path(current_user)
    else
      flash[:alert] = "please enter valid phone"
      render :new
    end
  end

  def destroy
    @phone = Phone.find_by(id: params[:id])
    @phone.destroy
    redirect_to user_profile_path
  end

  private

  def phone_params
    params.require(:phone).permit(:number, :country)
  end

  def valid_mobile?
    phone_object = TelephoneNumber.parse(params[:phone][:number], params[:phone][:country])
    phone_object.valid?
  end
end