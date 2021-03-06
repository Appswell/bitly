require 'minitest/autorun'
require 'rubygems'
require 'shoulda'
require 'flexmock/minitest'
require 'fakeweb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'bitly')

FakeWeb.allow_net_connect = false

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_get(url, filename, status=nil)
  options = {:body => fixture_file(filename)}
  options.merge!({:status => status}) unless status.nil?

  FakeWeb.register_uri(:get, url, options)
end

def api_key
  'test_key'
end
def login
  'test_account'
end
def access_token
  'test_access_token'
end

class Minitest::Test
  def teardown
    FakeWeb.clean_registry
  end
end
