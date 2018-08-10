module SwitchTenant
	def self.switch_subdomain subdomain
  		Apartment::Tenant.switch!(subdomain)
  	end
end