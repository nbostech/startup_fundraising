$redis = Redis::Namespace.new("idn_api_rails", :redis => Redis.new) if ENV["CACHE_ENABLED"] == "true"