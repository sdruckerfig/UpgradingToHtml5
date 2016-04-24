// JavaScript Document

var sObj = null
var objInterval = null;
var rotateInterval = 0;
var rotation = 0;
var direction = 0;

function rotate() {
 sObj = document.getElementById('ship');
 rotation += rotateInterval;
 var T = "rotate(" + rotation + ",100,25)";
 sObj.setAttribute("transform",T);
 
}

function startRotate(e) {
	switch(e.keyCode) {
		case 39:
		  if (rotateInterval != 5 || !objInterval) {
		   rotateInterval = 5;
		   objInterval=setInterval("rotate()",50);
		  }
		  break;
		case 37: 
		  if (rotateInterval != -5 || !objInterval) {
		  rotateInterval = -5;
		  objInterval=setInterval("rotate()",50);
		  }
		  break;	
	}
}

function stopRotate(e) {
	if (objInterval) {
		clearInterval(objInterval);	
	}
}

document.onkeydown = startRotate;
document.onkeyup = stopRotate;