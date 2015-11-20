#! /usr/bin/env ruby

require_relative 'token'


token = OAuth::Token.new('3cbcc3d3-094d-4006-9849-0d11d61f484d', '27b10960-2be3-4ed6-94d6-519747fd7073',
                         '875458f6-8054-42c6-afd3-3c50acea2a23', '7\MB2g3KtZ=f8YD;Ci7J')
request_token = token.get_token
puts token.inspect