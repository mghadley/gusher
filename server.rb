require 'sinatra'
require 'pry'


class User
	attr_accessor :username, :email, :password, :posts, :following, :id

	def initialize(username, email, password, posts = [], following = [])
		@username = username
		@email = email
		@password = password
		@posts = posts
		@following = following
		if $users.empty?
			@id = 1
		else
			@id = $users.last.id + 1
		end
	end
end

$users = []
$current_user = ''

@beyonce = User.new("Beyonce", "beyonce@queenb.com", "password", 
	                 ["Gusher is so great omg", "Cruisin on my yacht", "Becky with the good hair"])
$users << @beyonce

get '/' do
	redirect to ('/sign_up') if $current_user == ''
	erb :home
end

get '/sign_up' do
	erb :sign_up
end

get '/log_in' do
	erb :log_in
end

post '/sign_up' do
	binding.pry
	@user = User.new(params[:username], params[:email], params[:password])
	$users << @user
	$current_user = @user
	binding.pry
end

post '/log_out' do
	$current_user = ''
	redirect to ('/sign_up')
end


