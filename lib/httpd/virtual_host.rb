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
require 'httpd/alias_helper'

module Httpd
  
  class VirtualHost < Base
    include ::Httpd::AliasHelper
    
    attr_reader :interface
    attr_reader :server_name
    attr_reader :server_alias
    attr_reader :server_admin
    attr_reader :document_root
    
    def initialize(interface)
      super()
      @interface = interface
      @server_aliases = []
    end
    
    def server_name(value)
      #@server_name = value
      elements << Raw.new("  ServerName #{value}")
    end
    
    def server_alias(value)
      #@server_aliases << value
      elements << Raw.new("  ServerAlias #{value}")
    end
    
    def server_admin(value)
      elements << Raw.new("  ServerAdmin #{value}")
    end

    def document_root(value)
      #@document_root = value
      elements << Raw.new("  DocumentRoot #{value}")
    end
    
    def directory(path, &block)
      directory = ::Httpd::Directory.new(path)
      elements << directory
      directory.instance_eval(&block)
    end
    
    def redirect_permanent(source, target)
      elements << Raw.new("  RedirectPermanent #{sprintf('%-30s', source)} #{target}")
    end

    def redirect_match(source, target)
      elements << Raw.new("  RedirectMatch #{sprintf('%-30s', source)} #{target}")
    end
    
    def to_conf
      lines = []
      lines << "<VirtualHost #{@interface}>"
      #lines << "  ServerName #{@server_name}"
      #@server_aliases.each do |server_alias|
      #  lines << "  ServerAlias #{server_alias}"
      #end
      #lines << "  DocumentRoot \"#{@document_root}\"" if @document_root
      
      lines += super()
      lines << "</VirtualHost>"
      lines << ""
      return lines.flatten
    end
  end
end