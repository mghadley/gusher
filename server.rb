require 'sinatra'
require 'pry'

require_relative 'lib/user.rb'

$users = []
$current_user = ''

@beyonce = User.new("Beyonce", "beyonce@queenb.com", "password", 
	                 {Time.now.usec => "Gusher is so great omg", Time.now.usec => "Cruisin on my yacht", Time.now.usec =>"Becky with the good hair"})
$users << @beyonce

@obama = User.new("Obama", "obama@potus.com", "password", {Time.now.usec => "Hangin with my girl Beyonce", Time.now.usec => "Dang it Joe what are you doing",
									Time.now.usec => "Can't wait to move out of this dump.", Time.now.usec => "Who is Becky with the good hair??"})
$users << @obama

@jakesorce = User.new("Jake Sorce", "jakes@ridingthegnar.com", "password",
					{Time.now.usec => "Code4life", Time.now.usec => "Shreddin' the fresh pow", Time.now.usec => "Need a nap right MEOWWW", Time.now.usec => "Beer or Break"})
$users << @jakesorce

@michaeljackson = User.new("MJ", "neverneverland@aol.com", "password",
					{ Time.now.usec => "Gushing from the other-side",  Time.now.usec => "yeeehooo", 
						 Time.now.usec => "moon-walking through the silver-lined clouds", 
						 Time.now.usec => "ivory socks and ebony loafers"})
$users << @michaeljackson

@davejungst = User.new("Dave Jungst", "dave@yoga.com", "password",
					{ Time.now.usec => "I prefer to be called DJ", Time.now.usec => "Working on developing my yoga app",
						Time.now.usec => "I am impressed by Gush everyday", Time.now.usec => "Just gushing about my yoga",
						Time.now.usec => "Hot yoga is the best way to warm up from a freezing classroom"})
$users << @davejungst

get '/' do
	redirect to ('/sign_up') if $current_user == ''
	@all_gushes = {}
	$current_user.following.each do |followee|
		followee.posts.each do |time, post|
			@all_gushes[time] = {followee.username => post}
		end
	end
	@all_gushes = @all_gushes.sort.to_h
	erb :home
end

get '/profile' do
	erb :profile
end 

get '/sign_up' do
	erb :sign_up
end

get '/log_in' do
	erb :log_in
end

get '/find_followers' do
	erb :find_followers
end

post '/sign_up' do
	if params[:username].empty? || params[:email].empty? || params[:password].empty?
		erb :sign_up_error
	else
		@user = User.new(params[:username], params[:email], params[:password])
		@user.following << @user
		$users << @user
		$current_user = @user
		redirect to ('/')
	end
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
	redirect to ('/log_in')
end

post '/new_post' do
	$current_user.posts[Time.now.usec] = params[:gush]
	redirect to ('/')
end

post '/follow' do
	user_to_follow = $users.find {|user| user.id == params[:user].to_i}
	$current_user.following << user_to_follow
	redirect to ('/')
end

not_found do
	status 404
	'not found'
end
