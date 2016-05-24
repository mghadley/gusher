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