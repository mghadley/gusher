require 'sinatra'
require 'pry'


class User
	attr_accessor :name, :posts

	def initialize(username, email, posts = [], following = [])
		@username = username
		@email = email
		@posts = posts
		@following = following
	end
end 



get '/' do
	$users = [] if @users.nil?
	binding.pry
end

get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
	binding.pry
	@user = User.new(params[:username], params[:email])
	$users << @user
	binding.pry
end

