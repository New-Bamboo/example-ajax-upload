require 'rubygems'
require 'rack'
require 'sinatra'
require 'example_html5_upload'

use Rack::RawUpload
run Sinatra::Application
