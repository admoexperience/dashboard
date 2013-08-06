require 'dashing'
require 'redis-objects'

USERNAME = ENV['USER_NAME'] || 'admin'
PASSWORD =  ENV['USER_PASSWORD'] || 'password'

configure do
  set :auth_token, (ENV['AUTH_TOKEN'] || 'YOUR_AUTH_TOKEN')

  if ENV.has_key? "REDISTOGO_URL"
    # Redis URI is stored in the REDISTOGO_URL environment variable
    # Use Redis for our event history storage
    # This works because a 'HashKey' object from redis-objects allows
    # the index access hash[id] and set hash[id] = XYZ that dashing
    # applies to the history setting to store events
    redis_uri = URI.parse(ENV["REDISTOGO_URL"])
    Redis.current = Redis.new(:host => redis_uri.host,
                              :port => redis_uri.port,
                              :password => redis_uri.password)

    set :history, Redis::HashKey.new('dashing-hash')
  end

  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [USERNAME, PASSWORD]
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
