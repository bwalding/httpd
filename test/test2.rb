################################################################################
#  Copyright 2006-2011 Ben Walding
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
################################################################################

$: << File.dirname(__FILE__) + "/../lib"
require 'httpd'
require 'test/unit'

class ProjectVirtualHost < ::Httpd::VirtualHost
  def initialize(key, &block )
    super( '*:443' )
    @key = key
    server_name "#{key}.example.com"
    self.instance_eval(&block)
  end
  
end

# Provides a basic vhost that redirects all traffic to the https version
class RedirectToSSLVirtualHost < ::Httpd::VirtualHost
  def initialize(hostname, &block)
    super( '*:80' )
    self.instance_eval(&block)
    
    server_name hostname
    raw "  RedirectPermanent / https://#{hostname}/"
  end
end

class Httpd2Test < Test::Unit::TestCase

  def txest_comprehensive
    httpd = ::Httpd::Httpd.new()
    httpd.disclaimer 'This configuration is generated automatically and will be overwritten'
    httpd.virtual_host do
      server_name 'foo.example.com'
      server_alias 'alpha.foo.example.com'
      document_root '/tmp/foo'
      
      comment "Not used any more..."
      file_alias("/goo", "/tmp/goo")
    end

    httpd.virtual_host do
      server_name 'beta.foo.example.com'
      document_root '/tmp/beta'
      
      include_file "/var/fred.txt"
      directory "/tmp" do
      end
    end
    
    httpd.elements << ProjectVirtualHost.new('graham')
    httpd.elements << RedirectToSSLVirtualHost.new('graham.example.com')
    
    puts "\n# Configuration:"
    puts httpd.to_conf.join("\n")
    puts "# Done"
  end

  def test_com
    httpd = ::Httpd::Httpd.new()
    httpd.disclaimer 'This configuration is generated automatically and will be overwritten'
    
    httpd.elements << ProjectVirtualHost.new('graham') do
      location('/location') do
        directory_index 'location.html'
      end

      directory('/directory') do
        directory_index 'directory.html'
      end
    end
    
    httpd.elements << RedirectToSSLVirtualHost.new('graham.example.com') do
      server_alias "bumpkin.example.com"
    end
    
    
    puts "\n# Configuration:"
    puts httpd.to_conf.join("\n")
    puts "# Done"
  end
  
end

