# Example of Ajax-powered file uploads

A simple application written in Ruby, using the Sinatra framework. Hopefully it should be easy to read even to those who don't know Ruby.

To run it, do:

    rackup -I.

And the application should be accessible at `http://localhost:9292`.

# What to look at?

The important bit is the client code, found at `/public/index.html`

This code is thoroughly commented, and there's additional information at our original article covering [Ajax file uploads](http://blog.new-bamboo.co.uk/2010/7/30/html5-powered-ajax-file-uploads)

# Not really HTML5

Although initially I (Pablo Brasero) referred to this technique as HTML5 uploads, this is not actually correct. The interfaces used are described in two separate specifications, different from HTML5. These are *XMLHttpRequest level 2* and the *File API*.

Also, remember that these specifications are, at the time of writing, working drafts. They could change in the future, before they become full-fledged W3C recommended standards.
