class User < ApplicationRecord
	has_secure_password
	validates_presence_of :user_name, :email, :password
	validates_uniqueness_of :user_name, :email

	def self.create_admin values
		user = self.new
		user.user_name = values["user_name"]
		user.password = values["password"]
		user.email = values["email"]
		status={}
		if user.save
			status["info"] = "Success"
      		status["msg"] = "Work space created"
	    else
	    	status["info"] = "Error"
	      	status["msg"] = user.errors.full_messages
	    end
	end
end
