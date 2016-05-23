require 'sinatra'
require 'pry'

@users = {}

class User
	attr_accessor :name, :posts

	def initialize(name, email, posts = [], following = [])
		if @users.empty?
			@id = 1
		else
			@id = @users.values.last + 1
		end
		@name = name
		@email = email
	end
end

class Post

end

get '/' do
# link to sign up or log in	
end

get '/sign_up' do
	erb :sign_up
end

