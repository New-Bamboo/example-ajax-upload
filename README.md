# Example of HTML5-powered file uploads

A simple application written in Ruby, using the Sinatra framework. Hopefully it should be easy to read even to those who don't know Ruby.

To run it, just do:

    rackup

And the application should be accessible at `http://localhost:9292`.

If you want to know more, have a look at our [blog post covering HTML5 file uploads](http://blog.new-bamboo.co.uk/2010/7/30/html5-powered-ajax-file-uploads)

# Rack::RawUpload

This example includes and uses a piece of middleware called [Rack::RawUpload](http://github.com/newbamboo/rack-raw-upload), also by us. It makes handling this kind of uploads much easier.