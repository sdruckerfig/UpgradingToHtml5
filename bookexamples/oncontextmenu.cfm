<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Using ContextMenu</title>
<style>

label { width: 100px; float: left;}
br { clear:both}

#customMenu {
 position: absolute;
 z-index:2;
 display: none;
 background-color: silver;
 width: 200px;
 height: 30px;	
 font-family: Arial, Helvetica, sans-serif;
 padding: 5px;
 }
</style>

<script language="JavaScript">
  function fnCustomMenu() {
		var obj = document.getElementById('customMenu');
		obj.style.left = ( window.event.clientX - 5) + 'px';
		obj.style.top = (window.event.clientY - 5) + 'px';
		obj.style.display='block';
		return false;
  }
  function pasteName() {
		document.forms[0].pagetitle.value = document.forms[0].pagename.value;
		document.getElementById('customMenu').style.display='none';  
  }
</script>
</head>

<body>

<div id="customMenu" onmouseout="this.style.display='none'">
<a href="javascript:pasteName()">Paste Name</a>
</div>

<form>
<label for="pagename">Page Name</label>
<input type="text" name="pagename">
<br />

<label for="pagetitle">Page Title</label>
<input type="text" name="pagetitle" oncontextmenu="return fnCustomMenu()">
</form>

</body>
</html>