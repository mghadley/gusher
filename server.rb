require 'sinatra'
require 'pry'


class User
	attr_accessor :username, :email, :posts, :following

	def initialize(username, email, posts = [], following = [])
		@username = username
		@email = email
		@posts = posts
		@following = following
	end
end 

$users = []
$current_user = ''

get '/' do
	binding.pry
end

get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
	binding.pry
	@user = User.new(params[:username], params[:email])
	$users << @user
	$current_user = @user
	binding.pry
end

post

