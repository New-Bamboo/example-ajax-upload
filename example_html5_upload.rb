require 'sinatra'
require 'pp'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/' do
  our_file = params.delete('our-file')
  "Received form fields:\n\n" + pretty_str(params) +
    "\nAnd uploaded file:\n\n" + file_info(our_file)
end

post '/upload' do
  file_info params['our-file']
end

def file_info(file)
  details = {
    :filename => file[:filename],
    :type => file[:type],
    :head => file[:head],
    :name => file[:name],
    :tempfile_path => file[:tempfile].path,
    :tempfile_size => file[:tempfile].size,
  }
  pretty_str details
end

def pretty_str(obj)
  ''.tap{|output| PP.pp(obj, output) }
end