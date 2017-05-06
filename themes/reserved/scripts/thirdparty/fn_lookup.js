	var i=0;
	var retval= new Array(3);
	retval[0] = "3";
	retval[1] = " ";
	retval[2] = " ";
	retval[4] = "";
	retval[5] = "";

	function doSearch(text) {
		retval[0] = "1";
		retval[1] = text;
		retval[3] = document.aspnetForm.csort.value;
		retval[4] = "";
		retval[5] = "";
		window.returnValue = retval;
		window.close();
	}

	function showAll() {
		retval[0] = "1";
		retval[1] = "";
		retval[3] = document.aspnetForm.csort.value;
		retval[4] = "";
		retval[5] = "";
		window.returnValue = retval;
		window.close();
	}

	function goPage(x)	{
		retval[0] = "1";
		retval[1] = document.aspnetForm.bSearchText.value;
		retval[2] = x;
		retval[3] = document.aspnetForm.csort.value;
		retval[4] = "";
		retval[5] = "";
		window.returnValue = retval;
		window.close();
	}

	function doSort(nb, mode, fieldname) {
		if (!event.shiftKey)	{
			document.aspnetForm.csort.value = "";
		}
		if (mode==1) {
			document.aspnetForm.csortAsc.value = fieldname;
		}
		if (mode==2) {
			document.aspnetForm.csortDesc.value = fieldname;
		}
		//browse.submit();

		retval[0] = "1";
		retval[1] = document.aspnetForm.bSearchText.value;
		retval[3] = document.aspnetForm.csort.value;
		retval[4] = document.aspnetForm.csortAsc.value;
		retval[5] = document.aspnetForm.csortDesc.value;
		window.returnValue = retval;
		window.close();
		
	}

	function sendGUID(GUID, ID, Name,Extra1,Extra2,Extra3,Extra4,Extra5,Extra6,Extra7,Extra8) {
		do {

			ID=ID.replace('##UnvalidChar$%',"'");
	
		}while(ID.indexOf('##UnvalidChar$%')>-1)
		do {

			Name=Name.replace('##UnvalidChar$%',"'");

		}while(Name.indexOf('##UnvalidChar$%')>-1)
		retval[0]  = "2";
		retval[1]  = GUID;
		retval[2]  = ID;
		retval[3]  = Name;
		retval[6]  = Extra1;
		retval[7]  = Extra2;
		retval[8]  = Extra3;
		retval[9]  = Extra4;
		retval[10] = Extra5;
		retval[11] = Extra6;
		retval[12] = Extra7;
		retval[13] = Extra8;
		window.returnValue = retval;
		
		window.close();
	}

	function closeTheDoor() {
		window.returnValue = retval;
		window.close();
	}
