window.onload = function(){
  var md = /\?(.*?)-(.*)/.exec(location.search);
  if (md){
    var x = parseInt(md[1], 16);
    var y = parseInt(md[2], 16);
    var table = document.getElementById('maptable');
    Array.from(table.getElementsByTagName('TR')).forEach(function(tr, cy){
      Array.from(tr.getElementsByTagName('TD')).forEach(function(td, cx){
        if ((x == 0xFF || x == cx) && (y == 0xFF || y == cy)){
          td.style.border = '2px solid red';
        }
      });
    });
  }
}
