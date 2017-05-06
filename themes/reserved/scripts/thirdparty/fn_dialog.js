	var i=0;
	var retval= new Array(4);
	retval[0] = "3";
	retval[1] = "";
	retval[2] = "";
	retval[3] = "";
	function sendGUID(isPrintOnly) {
		retval[1] =document.aspnetForm.printerGUID.value;
		retval[2] =document.aspnetForm.radioValue.value;
		retval[3] = isPrintOnly;
		if(document.aspnetForm.isPrintOnly.value==0&&document.aspnetForm.radioValue.value=='')
			alert('Please select Printer To');
		else {
			retval[0]="1";
			window.returnValue = retval;
			window.close();
		}
	}

	function radioClick(value) {
		document.aspnetForm.radioValue.value = value;
	}
	
	function closeTheDoor() {
		window.returnValue = '';
		window.close();
		
	}