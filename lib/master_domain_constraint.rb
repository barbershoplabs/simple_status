class MasterDomainConstraint
  def self.matches?(request)
    request.subdomain == "www" || request.subdomain.empty?
  end
end
