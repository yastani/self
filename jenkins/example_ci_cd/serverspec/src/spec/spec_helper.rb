require 'serverspec'
require 'docker'

# backendを :dockerで指定
set :backend, :docker

# docker_urlに`DOCKER_HOST`を指定
set :docker_url, ENV["DOCKER_HOST"]

image = Docker::Image.build_from_dir('../../nginx')
set :docker_image, image.id
set :docker_container, ENV['DOCKER_CONTAINER']

=begin
if ENV['DOCKER_IMAGE']
  image = Docker::Image.build_from_dir('.')
  set :docker_image, image.id
elsif ENV['DOCKER_CONTAINER']
  set :docker_container, ENV['DOCKER_CONTAINER']
end
=end

# TODO https://github.com/swipely/docker-api/issues/202
Excon.defaults[:ssl_verify_peer] = false

=begin
describe "Dockerfile" do
  before(:all) do
  	image = Docker::Image.build_from_dir('.')
  	set :docker_image, image.id
  end
end
=end