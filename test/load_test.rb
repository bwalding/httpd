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

class LoadTest < Test::Unit::TestCase

  def test_basic
    filename = 'test-httpd.conf'
    puts "Writing to #{filename}"
    File.open(filename, 'w') do |io|
      httpd = ::Httpd::Httpd.new() do
        max = 100000
        start = Time.new
        1.upto(max) do |i|
          if (i % 5000) == 0
            finish = Time.new
            ms = ((finish - start) * 1000).to_i
            puts "Done #{i}/#{max}  (#{ms}ms)"
            start = Time.new
          end 
          virtual_host do
            server_name "instance-#{i}.example.com"
            document_root "/tmp/instance-#{i}"
          end
        end
      end
      io.write(httpd.to_conf)
    end
    puts "Completed writing to #{filename}"
  end
  
end

