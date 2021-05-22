require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './database_connection_setup'
require_relative './lib/comment'
require_relative './lib/user'

class Bookmarks < Sinatra::Base
    register Sinatra::Flash
    configure :development do
        register Sinatra::Reloader
    end

    enable :sessions, :method_override

    get '/' do
        erb(:home)
    end

    get '/bookmarks' do
        @user = User.find(id: session[:user_id])
        @bookmarks = Bookmark.all_bookmarks
        erb :'bookmarks/index'
    end

    get '/bookmarks/new' do
        erb(:'bookmarks/new')
    end

    post '/bookmarks' do
        flash[:notice] = "You must submit a valid URL." unless Bookmark.add_bookmark(url: params[:url], title: params[:title])
        redirect '/bookmarks'
    end

    delete '/bookmarks/:id' do
        Bookmark.delete(id: params[:id])
        redirect '/bookmarks'
    end

    get '/bookmarks/:id/edit' do
        @bookmark = Bookmark.find(id: params[:id])
        erb :'bookmarks/edit'
    end

    patch '/bookmarks/:id' do
        Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
        redirect('/bookmarks')
    end

    get '/bookmarks/:id/comments/new' do
        @bookmark_id = params[:id]
        erb :'comments/new'
    end

    post '/bookmarks/:id/comments' do
        Comment.create(text: params[:comment], bookmark_id: params[:id])
        redirect '/bookmarks'
    end

    get '/users/new' do
        erb :"users/new"
    end

    post '/users' do
        user = User.create(email: params['email'], password: params['password'])
        session[:user_id] = user.id
        redirect '/bookmarks'
    end

    get '/sessions/new' do
        erb :"sessions/new"
    end

    post '/sessions' do
        user = User.authenticate(email: params[:email], password: params[:password])
        session[:user_id] = user.id
        redirect('/bookmarks')
    end

    post '/sessions/destroy' do
        session.clear
        flash[:notice] = 'You have signed out.'
        redirect('/bookmarks')
      end

    run! if app_file == $0
    
end