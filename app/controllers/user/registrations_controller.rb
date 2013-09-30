class User::RegistrationsController < Devise::RegistrationsController

  layout :determine_layout

  private
    def determine_layout
      if !user_signed_in?
        "application"
      else
        "profile"
      end
    end
end