require 'infrataster/rspec'
require 'docker'

# backendを :dockerで指定
#set :backend, :docker

# docker_urlに`DOCKER_HOST`を指定
#set :docker_url, ENV["DOCKER_HOST"]

#image = Docker::Image.build_from_dir('../../nginx')
#set :docker_image, image.id
#set :docker_container, ENV['DOCKER_CONTAINER']

Infrataster::Server.define(
  :nginx,
  'localhost'
  #URI.parse(ENV['DOCKER_HOST']).host
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

# TODO https://github.com/swipely/docker-api/issues/202
Excon.defaults[:ssl_verify_peer] = false