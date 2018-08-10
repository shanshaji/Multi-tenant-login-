class Account < ApplicationRecord
	after_create :create_tenant

  	def create_tenant
    	Apartment::Tenant.create(subdomain)
  	end

  	def self.find_account subdomain
      self.find_by_subdomain(subdomain)
    end
end
