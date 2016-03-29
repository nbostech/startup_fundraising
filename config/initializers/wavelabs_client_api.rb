WavelabsClientApi.configure do |config|
  # Set this options to what makes sense for you
  # If you are using ENV variables setup the required ENV variables 
  config.api_host_url = ENV['IDN_HOST_URL']
  config.client_key = ENV['APP_CLIENT_ID']
  config.client_secret = ENV['APP_CLIENT_SECRET']

  # If you are not using ENV variables comment out the follwing lines
  # And provide your api server url, client key & client secret
  # config.api_host_url = "API Server Url"
  # config.client_key = "Client Key"
  # config.client_secret = "Client Secret"
end