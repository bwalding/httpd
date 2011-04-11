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
require 'test/unit'

class BasicTest < Test::Unit::TestCase

  def test_basic
    httpd = ::Httpd::Httpd.new() do
      virtual_host do
        server_name 'foo.example.com'
        server_alias 'alpha.foo.example.com'
        document_root '/tmp'
      end
    end
  end
  
  def test_multiple
    httpd = ::Httpd::Httpd.new()
    httpd.disclaimer 'This configuration is generated automatically and will be overwritten'
    httpd.virtual_host do
      server_name 'foo.example.com'
      server_alias 'alpha.foo.example.com'
      document_root '/tmp/foo'
    end

    httpd.virtual_host do
      server_name 'beta.foo.example.com'
      document_root '/tmp/beta'
    end
    
  end
  
end

