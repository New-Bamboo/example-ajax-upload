require 'sinatra'
require 'pp'

get '/' do
  HTML_CODE
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


#
# Javascript code
#

JS_CODE =<<-JS
var uploadBtn = document.getElementById('upload-button-id');
uploadBtn.onclick = function (evt) {
  var fileInput = document.getElementById('file-id');
  var file = fileInput.files[0];
  var formData = new FormData();
  var action = '/upload';
  formData.append('our-file', file);

  var xhr = new XMLHttpRequest();
  xhr.upload.addEventListener('loadstart', onloadstartHandler, false);
  xhr.upload.addEventListener('progress', onprogressHandler, false);
  xhr.upload.addEventListener('load', onloadHandler, false);
  xhr.addEventListener('readystatechange', onreadystatechangeHandler, false);
  xhr.open('POST', action, true);
  xhr.send(formData); // Simple!

  return false;

  function onloadstartHandler(evt) {
    var div = document.getElementById('upload-status');
    div.innerHTML = 'Upload started!';
  }

  function onloadHandler(evt) {
    var div = document.getElementById('upload-status');
    div.innerHTML = 'Upload successful!';
  }

  function onprogressHandler(evt) {
    var div = document.getElementById('progress');
    var percent = evt.loaded/evt.total*100;
    div.innerHTML = 'Progress: ' + percent + '%';
  }
  
  function onreadystatechangeHandler(evt) {
      var status = null;

      try {
          status = evt.target.status;
      }
      catch(e) {
          return;
      }

      if (status == '200' && evt.target.responseText) {
        var result = document.getElementById('result');
        result.innerHTML = '<p>The server saw it as:</p><pre>' + evt.target.responseText + '</pre>';
      }
  }
}
JS


#
# HTML code
#

HTML_CODE =<<-HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Ajax upload form</title>
</head>
<body>
<form action="/" method="post" enctype="multipart/form-data" id="form-id">
  <p><input id="file-id" type="file" name="our-file" /> <input type="button" value="Upload" id="upload-button-id" /></p>
  <p><label>Some other field: <input name="other-field" type="text" id="other-field-id" /></label></p>
  <p><input type="submit" value="Save" /></p>
  <script>
#{JS_CODE}
  </script>
  <p id="upload-status"></p>
  <p id="progress"></p>
  <pre id="result"></pre>
</form>
</body>
</html>
HTML
