require 'sinatra'
require 'pry'


class User
	attr_accessor :username, :email, :password, :posts, :following, :id

	def initialize(username, email, password, posts = {}, following = [])
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
	                 {Time.now.usec => "Gusher is so great omg", Time.now.usec => "Cruisin on my yacht", Time.now.usec =>"Becky with the good hair"})
$users << @beyonce

@obama = User.new("Obama", "obama@potus.com", "password", {Time.now.usec => "Hangin with my girl Beyonce", Time.now.usec => "Dang it Joe what are you doing",
									Time.now.usec => "Can't wait to move out of this dump."})
$users << @obama

@jakesorce = User.new("SorcenCode", "jakes@ridingthegnar.com", "password",
					{Time.now.usec => "Code4life", Time.now.usec => "Shreddin' the fresh pow", Time.now.usec => "Need a nap 
						right MEOWWW", Time.now.usec => "Beer or Break"})
$users << @jakesorce

@michaeljackson = User.new("MJ", "neverneverland@aol.com", "password",
					{ Time.now.usec => "Gushing from the other-side",  Time.now.usec => "yeeehooo", 
						 Time.now.usec => "moon-walking through the silver-lined clouds", 
						 Time.now.usec => "keeping it classy in the heavens: white socks & black loafers4EVAH" })
$users << @michaeljackson 

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

# profile page
# validate blank user login

post '/sign_up' do
	@user = User.new(params[:username], params[:email], params[:password])
	@user.following << @user
	$users << @user
	$current_user = @user
	redirect to ('/')
end

post '/log_in' do
	@user = $users.find {|user| user.username = params[:username]}
	if @user.password == params[:password]
		$current_user = @user
		redirect to ('/')
	else
		erb :failed_log_in
	end
end

post '/log_out' do
	$current_user = ''
	redirect to ('/sign_up')
end

post '/new_post' do
	$current_user.posts[Time.now.usec] = params[:gush]
	binding.pry
	redirect to ('/')
end


