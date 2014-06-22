Tiny bit.ly API Library for Ruby
================================
https://github.com/hermit/ruby-bitly

Copyright (c) 2010 Akio Kitano <akio.kitano.00@gmail.com>  
Copyright (c) 2011 katmagic <the.magical.kat@gmail.com>

You need bit.ly account and API key. See https://bit.ly/a/your_api_key

Sample:

	# Write your ID and API key as arguments
	bit = BitLy.new('bitlyapidemo', 'R_0da49e0a9118ff35f52f629d2d71bf07')
	url = bit.ly('http://betaworks.com/')

	# Or if you have ~/.bitly.rb, you can call it without arguments
	bit = BitLy.new
	url = bit.ly('http://betaworks.com/')

Example of ~/.bitly.json:

	{
		"login": "bitlyapidemo",
		"api_key": "R_0da49e0a9118ff35f52f629d2d71bf07"
	}
