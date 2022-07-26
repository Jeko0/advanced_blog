class UserDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate_all 

  def edit_profile
    if self == current_user 
      link_to t(:edit), edit_user_registration_path, class:"btn btn-warning"
    end
  end

  def profile_picture 
    self.avatar? ? image_tag(self.avatar_url) : image_tag("download.png")
  end

  def add_phone
    valid_user(link_to "Add Phone", add_phone_path, class:"btn btn-warning")
  end

  def add_location 
    valid_user(link_to "Add location", add_location_path, class:"btn btn-warning")
  end

  def become_vip 
    valid_user(render "charges/new", user: current_user)
  end

  def first_address
    address = user.locations
    address.first ? address.first.address : "no address"
  end

  def first_two_address
    self.locations.first(2)
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

    def valid_user(param)
      if current_user == self 
        param
      end
    end
end