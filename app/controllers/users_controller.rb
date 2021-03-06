class UsersController < ApplicationController
    get '/register' do
        erb :'/users/register'
    end

    post '/register' do
        if params[:name].present? && params[:email].present? && params[:password].present?
            @user = User.create(name: params[:name], email: params[:email], password: params[:password])
            session[:id] = @user.id
        else redirect to :'/register'
        end
        erb :'/users/login'
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect to :'/posts'
      else redirect to :'/login'
      end
    end

    get '/logout' do
        session.clear
        redirect to '/'
    end
end