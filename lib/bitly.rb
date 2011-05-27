#!/usr/bin/env ruby
# Tiny bit.ly API library for Ruby
# https://github.com/hermit/ruby-bitly
# License: The MIT License
# Copyright (c) 2010 Akio Kitano <akio.kitano.00@gmail.com>

require 'rubygems'
require 'json'
require 'net/http'
require 'cgi'

class BitLy
	# login is your bit.ly username; api_key is your bit.ly API key. See
	# https://bit.ly/a/your_api_key for more details. If ~/.bitly.rb exists, it
	# should be a JSON dictionary with 'login' and 'api_key' keys; in this case,
	# arguments need not be given.
  def initialize(login = nil, api_key = nil)
    @login = login
    @api_key = api_key
    unless @login or @api_key
      o = JSON.parse( File.read(File.join(ENV['HOME'], '.bitly.rb')) )
      @login = o['login']
      @api_key = o['api_key']
    end

    @con = Net::HTTP.new('api-ssl.bitly.com', 443)
    @con.use_ssl = true
  end

	# Shorten a URL.
  def ly(url)
    resp = @con.get("/v3/shorten?login=#@login&apiKey=#@api_key&longUrl=#{CGI.escape url}")
    r = JSON.parse(resp.body)
    unless r['status_code'] == 200
      raise BitLy::Error, r
    end
    r['data']['url'].sub('http://', 'https://')
  end

  class Error < RuntimeError
    def initialize(x)
      @result = x
    end
    attr :result
  end
end

# You can test this code, try "ruby bitly.rb"
if __FILE__ == $0
  begin
    bit = BitLy.new
    p bit.ly('http://betaworks.com/')
  rescue BitLy::Error => e
    p e.result
  end

  begin
    bit = BitLy.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
    p bit.ly('http://betaworks.com/')
  rescue BitLy::Error => e
    p e.result
  end
end
