module UserParams

	def self.remove_account_details account_params, user_params
	  	account_params.keys.each do |key|
      		user_params.delete(key)
    	end
    	user_params
	end
end