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

@obama = User.new("Obama", "obama@potus.com", "password", 
	["Hangin with my girl Beyonce", "Dang it Joe what are you doing",
					"Can't wait to move out of this dump."])
$users << @obama

@jakesorce = User.new("SorcenCode", "jakes@ridingthegnar.com", "password",
					["Code4life", "Shreddin' the fresh pow", "Need a nap 
						right MEOWWW", "Beer or Break"])
$users << @jakesorce

@michaeljackson = User.new("MJ", "neverneverland@aol.com", "password",
					["Gushing from the other-side", "yeeehooo", 
						"moon-walking through the silver-lined clouds", 
						"keeping it classy in the heavens: white socks & black loafers4EVAH" ])
$users << @hiimmichael 

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
	@user = User.new(params[:username], params[:email], params[:password])
	$users << @user
	$current_user = @user
	redirect to ('/')
end

post '/log_out' do
	$current_user = ''
	redirect to ('/sign_up')
end


