require 'sinatra'
require 'json'
require 'lib/rack/raw_upload'

get '/' do
  HTML_CODE
end

post '/' do
  JSON.generate(params[:file])
end


#
# Javascript code
#

JS_CODE =<<-JS
document.getElementById('the-file').onchange = function () {
  var fileInput = document.getElementById('the-file');
  var file = fileInput.files[0];

  var xhr = new XMLHttpRequest();
  xhr.open('POST', '/', true);
  xhr.upload.addEventListener('loadstart', onloadstartHandler, false);
  xhr.upload.addEventListener('progress', onprogressHandler, false);
  xhr.upload.addEventListener('load', onloadHandler, false);
  xhr.addEventListener('readystatechange', onreadystatechangeHandler, false);
  xhr.setRequestHeader("Content-Type", "application/octet-stream");
  xhr.setRequestHeader("X-File_name", file.name);
  xhr.send(file); // Simple!

  function onloadstartHandler(evt) {
      $('#upload-status').html('Upload started!');
  }

  function onloadHandler(evt) {
      $('#upload-status').html('Upload successful!');
  }

  function onprogressHandler(evt) {
      var percent = event.loaded/event.total*100;
      $('#progress').html('Progress: ' + percent + '%');
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
        $('#result').html('<p>The server saw it as:</p><pre>' + evt.target.responseText + '</pre>');
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
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
</head>
<body>

<input id="the-file" type=file name=file />
<script>
#{JS_CODE}
</script>
<p id="upload-status"></p>
<p id="progress"></p>
<div id="result"></div>
</body>
</html>
HTML
