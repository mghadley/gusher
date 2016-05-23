require 'sinatra'
require 'pry'


class User
	attr_accessor :name, :posts

	def initialize(username, email, posts = [], following = [])
		if @users.empty?
			@id = 1
		else
			@id = @users.values.last + 1
		end
		@username = username
		@email = email
	end

	def save
		@users << @user
	end
end 

class Post

end

get '/' do
	@users = [] if @users.nil?
	binding.pry
end

get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
	@user = User.new(params[:username], params[:email])
	@user.save
	binding.pry
end

