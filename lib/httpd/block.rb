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
  class Block < Base
    attr_reader :path
    
    def initialize(path)
      super()
      @path = path
    end
    
    def options(text)
      raw("  Options +Indexes")
    end
    
    def directory_index(text)
      raw("  DirectoryIndex #{text}")
    end
    
    def limit_except(verbs, content)
      limit_generic("LimitExcept", verbs, content)
    end
    
    def limit(verbs, content)
      limit_generic("Limit", verbs, content)
    end   
    
  private
  
    def limit_generic(mode, verbs, content)
      if verbs.is_a?(Array)
        verbs = verbs.collect { |verb| verb.to_s.upcase }.join(' ')
      end
  
      verbs = ' ' + verbs unless verbs.strip.empty?
  
      raw "  <#{mode}#{verbs}>"
      raw indent('    ', content.split("\n"))
      raw "  </#{mode}>"
    end
  end
end
    