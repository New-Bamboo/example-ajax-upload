require 'sinatra'
require 'json'

get '/' do
  HTML_CODE
end

post '/' do
  JSON.generate(params['our-file'])
end


#
# Javascript code
#

JS_CODE =<<-JS
document.getElementById('form-id').onsubmit = function (evt) {
  var form = document.getElementById('form-id');
  var formData = new FormData(form);
  var action = form.getAttribute('action');

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
  <input id="before-id" type="hidden" name="before" value="before-val" />
  <input id="file-id" type="file" name="our-file" />
  <input id="after-id" type="hidden" name="after" value="after-val" />
  <input type="submit" value="Upload!" />
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
