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
module Httpd
  class Base
    attr_reader :elements
    
    def initialize
      @elements = []
    end
    
    # Not necessarily a base element, but good enough
    def include_file(spec)
      elements << Raw.new("  Include '#{spec}'")
    end
    
    def comment(text)
      elements << Raw.new("  # #{text}")
    end
    
    def raw(text)
      elements << Raw.new(text)
    end
    
    def allow_override(text)
      element << Raw.new("  AllowOverride #{text}")
    end

    def elements 
      return @elements
    end
    
    def location(path, &block)
      location = ::Httpd::Location.new(path)
      elements << location
      location.instance_eval(&block)
    end
    
  protected
    
    def to_conf
      @elements.collect { |element|
        element.to_conf
      }.flatten
    end
    
    def indent(indent, lines)
      lines.flatten!
      lines.collect { |line| indent + line }
    end
  end
end