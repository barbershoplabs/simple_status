module MailgunConfig
  def self.client
    Mailgun(:api_key => 'key-5f887a3c17ktk3jnij7xwwveizcsj6e3', :domain => 'adamrubin.mailgun.org')
  end
end
