require 'rack/cors'

use Rack::Cors do
  allow do
    origins  'localhost:9292'
    resource '*'
  end
end
