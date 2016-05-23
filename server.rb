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

get '/' do
	redirect to ('/sign_up') if $current_user == ''
	erb :home
end

get '/sign_up' do
	erb :sign_up
end

get '/log_in' do

end



post '/sign_up' do
	@user = User.new(params[:username], params[:email], params[:password])
	$users << @user
	$current_user = @user
	redirect to ('/')
end


