class UserDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all 



  def first_address
    address = user.locations
    address.first ? address.first.address : translate("no_address") 
  end

  def first_3address
    self.locations.first(3)
  end

  def first_3numbers
    self.mobiles.first(3)
  end

  def add_address(current_user)
    if is_user_current_user?(current_user)
      link_to translate("add_address"), add_location_path
    end
  end
  
  def delete_address(current_user, address_id)
    if is_user_admin_or_current_user?(current_user)
      link_to translate("delete"), destroy_address_path(self.id, address_id), data: {
        turbo_method: :delete
      }, class: "btn btn-danger"
    end
  end

  def show_location(location)
    link_to location.address, nil, remote: true, data: { 
      controller: "locations",
      action: "locations#initMap",
      locations_latitude_param: "#{location.latitude}",
      locations_longitude_param: "#{location.longitude}"
    } 
  end
  private

  def is_user_current_user?(current_user)
    self == current_user
  end

  def is_user_admin_or_current_user?(current_user)
    current_user.admin? || self == current_user 
  end
end