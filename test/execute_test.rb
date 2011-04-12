################################################################################
#  Copyright (c) 2004-2011, by OpenXource (Australia). All rights reserved.
#
#  THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF OPENXOURCE
#
#  The copyright notice above does not evidence any
#  actual or intended publication of such source code.
################################################################################
$: << File.dirname(__FILE__) + "/../lib"
require 'httpd'
require 'test/unit'
  
require 'test/unit'

class ExecuteTest < Test::Unit::TestCase

  def test_1
    httpd = Httpd::Httpd.execute(File.dirname(__FILE__) + '/execute_test_1.conf')
    puts httpd.to_conf.join("\n")
  end

end    
