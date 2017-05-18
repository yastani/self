require 'spec_helper'

describe 'PHP config parameters' do

  context php_config('engine') do
    its(:value) { should eq 1 }
  end

  context php_config('memory_limit') do
    its(:value) { should eq '512M' }
  end

  context php_config('log_errors') do
    its(:value) { should eq 1 }
  end

  context php_config('file_uploads') do
    its(:value) { should eq 1 }
  end

  context php_config('allow_url_fopen') do
    its(:value) { should eq 1 }
  end

  context php_config('default_socket_timeout') do
    its(:value) { should eq 60 }
  end

  context php_config('post_max_size') do
    its(:value) { should eq '40M' }
  end

  context php_config('default_mimetype') do
    its(:value) { should eq 'text/html' }
  end

  context php_config('default_charset') do
    its(:value) { should eq 'UTF-8' }
  end

  context php_config('date.timezone') do
    its(:value) { should eq 'Asia/Tokyo' }
  end

  context php_config('session.cache_expire') do
    its(:value) { should eq 180 }
  end

end