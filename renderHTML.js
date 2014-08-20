var page = require('webpage').create(), fs = require('fs');

var fullpath = fs.workingDirectory + fs.separator + 'index.html';

page.viewportSize = { width: 800, height: 600 };

page.open(fullpath, function start(status) {
  page.render('render/index.png');
  phantom.exit();
});
