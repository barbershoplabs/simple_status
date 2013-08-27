class MasterDomainConstraint
  def self.matches?(request)
    request.subdomain == "www" || request.subdomain == "2c7ce99a" || request.subdomain.empty?
  end
end
