class Users::SessionsController < Devise::SessionsController
  layout "sign_in", only: [ :new, :create ]
end
