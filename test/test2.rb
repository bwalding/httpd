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
require 'httpd/init.rb'
require 'test/unit'

class ProjectVirtualHost < ::Httpd::VirtualHost
  def initialize(key, &block )
    @key = key
    super('*:80') do 
      server_name "#{key}.example.com"
      &block
    end
  end
  
  def to_conf
  end
end

class Httpd2Test < Test::Unit::TestCase

  def test_comprehensive
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
    
    puts "\n# Configuration:"
    puts httpd.to_conf.join("\n")
    puts "# Done"
  end
  
end

