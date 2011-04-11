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

class ::Httpd::Httpd < ::Httpd::Base
  attr_reader :disclaimer
  blocks = []
  
  def initialize(&block)
    super()
    @virtual_hosts = []
    @disclaimer = nil
    if (block)
      self.instance_eval(&block)
    end
  end
  
  def virtual_host(interface = '*:80', &block)
    virtual_host = ::Httpd::VirtualHost.new(interface)
    elements << virtual_host
    virtual_host.instance_eval(&block)
  end
  
  def disclaimer(value)
    @disclaimer = value
  end
  
  # We don't indent the top level
  def to_conf
    content = []
    content << "# " + @disclaimer + "\n" if @disclaimer
    content += super()
    return content
  end
  
end
