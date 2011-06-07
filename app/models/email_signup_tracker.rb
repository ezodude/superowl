class EmailSignupTracker
  MIXPANEL_DEV_TOKEN = "dd031f7e9d8924147c98d0b084f5a88f"
  MIXPANEL_PROD_TOKEN = "62a0ed3451e6e1c2d99d9645dfa3fd28" 

  def self.track_signup(email, ip_address, time=Time.now.utc.to_i)
    test_mode = (RAILS_ENV == 'production' ? 0 : 1)
    data = {
      'event' => 'Interested User Signup',
      'properties' => {
        'email' => email,
        'ip' => ip_address,
        'time' => time,
        'token' => (RAILS_ENV == 'production' ? MIXPANEL_PROD_TOKEN : MIXPANEL_DEV_TOKEN)
      }
    }.to_json
    data = ActiveSupport::Base64.encode64s(data)
    res = RestClient.post("http://api.mixpanel.com/track/", :data => data, :test => test_mode)
  end
end