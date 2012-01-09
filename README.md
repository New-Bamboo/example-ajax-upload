# Example of Ajax-powered file uploads

A simple application written in Ruby, using the Sinatra framework. Hopefully it should be easy to read even to those who don't know Ruby.

To run it, just do:

    rackup

And the application should be accessible at `http://localhost:9292`.

If you want to know more, have a look at our [blog post covering Ajax file uploads](http://blog.new-bamboo.co.uk/2010/7/30/html5-powered-ajax-file-uploads)

# Rack::RawUpload

This example includes and uses a piece of middleware called [Rack::RawUpload](http://github.com/newbamboo/rack-raw-upload), also by us. It makes handling this kind of uploads much easier.

# Not really HTML5

Although initially I (Pablo Brasero) referred to this technique as HTML5 uploads, this is actually correct. The interfaces used are described in two separate specifications, different from HTML5. These are *XMLHttpRequest level 2* and the *File API*.

Also, remember that these specifications are, at the time of writing, working drafts. They could change in the future, before they become full-fledged W3C recommended standards.