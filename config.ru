require 'rubygems'
require 'rack'
require 'sinatra'
require 'example_ajax_upload'

use Rack::RawUpload
run Sinatra::Application
