module MailgunConfig
  def self.client
    Mailgun(:api_key => 'key-06z2yx95tzrvgcuzqn6rlomzukdjr049', :domain => 'app.simplestatus.io')
  end
end
