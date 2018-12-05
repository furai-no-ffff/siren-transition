window.onload = function(){
  for (const li of Array.from(document.getElementsByTagName('LI'))) {
    li.addEventListener('dblclick', function(e){
      this.classList.toggle('transition-highlighted');
    });
  }
}
