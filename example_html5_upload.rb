require 'sinatra'
require 'pp'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/upload' do
  file = params['our-file']
  details = {
    :filename => file[:filename],
    :type => file[:type],
    :head => file[:head],
    :name => file[:name],
    :tempfile_path => file[:tempfile].path,
    :tempfile_size => file[:tempfile].size,
  }
  ''.tap{|output| PP.pp(details, output) }
end
