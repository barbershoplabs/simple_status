class CustomerDomainConstraint
  def self.matches?(request)
    request.subdomain != "www" && request.subdomain.present?
  end
end
