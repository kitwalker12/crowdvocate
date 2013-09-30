class User::SessionsController < Devise::SessionsController
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