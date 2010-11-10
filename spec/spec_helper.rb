$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'pt'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

Spec::Runner.configure do |config|
  config.before(:all) do
    FakeWeb.allow_net_connect = false
  end
end
