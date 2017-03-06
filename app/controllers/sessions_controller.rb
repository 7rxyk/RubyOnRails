class SessionsController < ApplicationController
  def new
    # render�i kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.disabled?
      redirect_to :back, notice: "Contact admin, plx"
    else
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
        redirect_to :back, notice: "Username and/or password mismatch"
      end
    end
  end

  def create_oauth
     user = User.find_by username: env["omniauth.auth"].info.nickname
     if user
       session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
     else
       user = User.new
       user.username = env["omniauth.auth"].info.nickname
       rand_password=('0'..'z').to_a.shuffle.first(8).join
       user.password = rand_password
       user.password_confirmation = rand_password
       user.save
       session[:user_id] = user.id
         redirect_to user_path(user), notice: "Welcome back!"
     end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus p��sivulle
    redirect_to :root
  end
end
