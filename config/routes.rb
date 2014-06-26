Currentuser::Services::Engine.routes.draw do
  get :sign_in, to: 'sessions#sign_in'
  get :sign_out, to: 'sessions#sign_out'
end
