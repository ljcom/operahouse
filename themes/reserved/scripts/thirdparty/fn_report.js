function PrintDirect(reportName, parameter, outputtype, titleName, subtitleName, PathDPLX) {

    var parvalue1 = "";
    var pardplx = "";


    do {
        if (parameter.indexOf(',') > -1) {
            parid = parameter.substring(0, parameter.indexOf(','));
            parid1 = parid

            do {
                parid1 = parid1.replace('*', '');
            }
            while (parid1.indexOf('*') > -1)
            parid1 = trim(parid1);
            if (parid1.substring(0, 1) == '#') {
                parid1 = parid1.replace("#", "");
                parid1 = parid1.replace("#", "");
                parvalue = parid1;
            }
            else {
                if (document.forms(0).elements(parid1).type == 'checkbox') {
                    var r = document.forms(0).elements(parid1).checked ? "1" : "0";
                    parvalue = "" + r + "";
                }
                else {
                    parvalue = document.forms(0).elements(parid1).value;
                }
                parid = parid.replace(parid1, parvalue);

            }
            parvalue1 += "''" + parvalue + "'',";
            pardplx += parid1 + ":''" + parvalue + "'',";
            parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
        }
        else {
            //alert(parameter.length);
            var parlast = "";
            if (parameter.length > 0) {
                do {
                    parameter = parameter.replace('*', '');
                    parlast = parameter;
                }
                while (parameter.indexOf('*') > -1)
                parameter = trim(parameter);
                if (parameter.substring(0, 1) == '#') {
                    parameter = parameter.replace("#", "");
                    parameter = parameter.replace("#", "");
                    parvalue1 += "''" + parameter + "''";
                }
                else {
                    if (document.forms(0).elements(parameter).type == 'checkbox') {
                        var r = document.forms(0).elements(parameter).checked ? "1" : "0";
                        parvalue1 += "" + r + "";
                    }
                    else {
                        parvalue1 += "''" + document.forms(0).elements(parameter).value + "''";
                        pardplx += parlast + ":''" + document.forms(0).elements(parameter).value + "''";

                    }
                }
                parameter = parvalue1;
            }
            break;
        }
    }
    while (parameter.indexOf(',') > -2)
    parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
    //alert('OPHCore/api/msg_rptDialog.aspx?parameter='+parameter+'&outputType=2'+'&reportName='+reportName);
    if (outputtype == 2) {
        window.frames['frmMessage'].location = 'OPHCore/api/msg_rptDialog.aspx?parameter=' + pardplx + '&isPrintOnly=0&outputType=' + outputtype + '&reportName=' + reportName + '&titleName=' + titleName + '&subtitleName=' + subtitleName;
    }
    if (outputtype == 1 && PathDPLX != "") {
        window.frames['frmMessage'].location = '../../../modules/report/DPLX/SimpleReport.aspx?parameter=' + pardplx + '&isPrintOnly=0&outputType=' + outputtype + '&reportName=' + reportName + '&titleName=' + titleName + '&subtitleName=' + subtitleName + '&pathdplx=' + PathDPLX;
    }

} 

//function PrintDirect(reportName, parameter, outputtype, titleName, subtitleName) {

//    var parvalue1 = "";

//    do {
//        if (parameter.indexOf(',') > -1) {
//            parid = parameter.substring(0, parameter.indexOf(','));
//            parid1 = parid

//            do {
//                parid1 = parid1.replace('*', '');
//            }
//            while (parid1.indexOf('*') > -1)
//            parid1 = trim(parid1);
//            if (parid1.substring(0,1) == '#') {
//                parid1 = parid1.replace("#", "");
//                parid1 = parid1.replace("#", "");
//                parvalue = parid1;
//            }
//            else {
//                if (document.forms(0).elements(parid1).type == 'checkbox') {
//                    var r = document.forms(0).elements(parid1).checked ? "1" : "0";
//                    parvalue = "" + r + "";
//                }
//                else {
//                    parvalue = document.forms(0).elements(parid1).value;
//                }
//                parid = parid.replace(parid1, parvalue);

//            }
//            parvalue1 += "''" + parvalue + "'',";
//            parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
//        }
//        else {
//            //alert(parameter.length); 
//            if (parameter.length > 0) {
//                do {
//                    parameter = parameter.replace('*', '');
//                }
//                while (parameter.indexOf('*') > -1)
//                parameter = trim(parameter);
//                if (parameter.substring(0, 1) == '#') {
//                    parameter = parameter.replace("#", "");
//                    parameter = parameter.replace("#", "");
//                    parvalue1 += "''"+parameter+"''";
//                }
//                else {
//                    if (document.forms(0).elements(parameter).type == 'checkbox') {
//                        var r = document.forms(0).elements(parameter).checked ? "1" : "0"; 
//                        parvalue1 += "" + r + "";
//                    }
//                    else {
//                        parvalue1 += "''" + document.forms(0).elements(parameter).value + "''";
//                    }
//                }
//                parameter = parvalue1;
//            }
//            break;
//        }
//    }
//    while (parameter.indexOf(',') > -2)
//    parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
//    //alert('OPHCore/api/msg_rptDialog.aspx?parameter='+parameter+'&outputType=2'+'&reportName='+reportName);
//    window.frames['frmMessage'].location = 'OPHCore/api/msg_rptDialog.aspx?parameter=' + parameter + '&isPrintOnly=0&outputType=' + outputtype + '&reportName=' + reportName + '&titleName=' + titleName + '&subtitleName=' + subtitleName;
//} 




function doDialog1(aspfile1,parameter,reportName,isReportHTML) 
{
    if(isReportHTML==1) {
        reportName = document.forms(0).elements(reportName).value;
	    //reportName=eval("document.all."+reportName+".value");
	}
	if (showModalDialog) 
	{
	    var par,parvalue,parid,parid1,parvalue1;
		var sRtn = new Array(10);
		sRtn[0]	= "0";			//flag
		sRtn[1]	= " ";			//elTarget	//searchtext
		sRtn[2] = " ";			//elName	//pageno
		
		sRtn[3] = "";			//Add-3		//csort
		sRtn[4] = "";			//Add-4		//csortasc
		sRtn[5] = "";			//Add-5		//csortdesc
		sRtn[6] = " ";			//Add-6
		sRtn[7] = " ";			//Add-7
		sRtn[8] = " ";			//Add-8
		sRtn[9] = " ";			//Add-9
		sRtn[10]= " ";			//Add-10
		sRtn[11]= " ";			//Add-11
		sRtn[12]= " ";			//Add-12
		parvalue1="";
		do 
		{
		    if(parameter.indexOf(',')>-1)
			{ 
			    parid=parameter.substring(0,parameter.indexOf(','));
				parid1=parid
				do
				{
				    parid1=parid1.replace('*','');
				}
				while(parid1.indexOf('*')>-1)

				parvalue = document.forms(0).elements(parid1).value;				
				//parvalue=eval("document.all."+parid1+".value");
				parid=parid.replace(parid1,parvalue);
				parvalue1+="''"+parvalue+"'',";
				parameter=parameter.substring(parameter.indexOf(',')+1,parameter.length);
			}
			else
			{
			    do
			    {
					parameter=parameter.replace('*','');
				}
				while (parameter.indexOf('*') > -1)
				parvalue1 += "''" + document.forms(0).elements(parameter).value + "''";
				//parvalue1+="''"+eval("document.all."+parameter+".value")+"''";
				parameter=parvalue1;
				break;
			}
		}
		while(parameter.indexOf(',')>-2)
			
		sRtn=showModalDialog(aspfile1 ,"","center=yes;status=no;help=no;dialogWidth=300pt;dialogHeight=200pt");
			
		if (sRtn != undefined)
		{
		    if(sRtn[0]==1)
		        window.frames['frmMessage'].location='OPHCore/api/msg_rptDialog.aspx?parameter='+parameter+'&outputType='+sRtn[2]+'&printerGUID='+sRtn[1]+'&reportName='+reportName+'&isPrintOnly='+sRtn[3];
		}
	}
	else
		alert("Internet Explorer 4.0 or later is required.")
}

function removeoption(nama)
{
  var anOption = top.document.forms(0).elements(nama);
  while (anOption.length > 0)
  {
    anOption.remove(anOption.length - 1);
  }
}	

function disablecombo(nama) {
    top.document.forms(0).elements(nama).display='none';
    //eval('top.document.forms(0).' + nama + ".display='none'");
}

function optionselected(nama,nilai)
{
  var anOption = top.document.forms(0).elements(nama);
  var i;
  for (i = anOption.length - 1; i>=0; i--) {
    if (anOption.options[i].value==nilai) {
    	anOption(i).selected=true ;
    }
  }
}

function doFilterReport() {
    var tablename = document.forms(0).tablename.value;
    var keyfieldlist = document.forms(0).keyfieldlist.value;
    var namefieldlist = document.forms(0).namefieldlist.value;
    var combolist = document.forms(0).combolist.value;
    var sqlstrlist = document.forms(0).sqlstrlist.value;
    var wherefieldlist = document.forms(0).wherefieldlist.value;
    var selectedvalue = document.forms(0).selectedvalue.value;
		
		window.frames['frmMessage'].location='OPHCore/api/msg_report.aspx?defaulttyp=0&tablename='+tablename+'&keyfieldlist='+keyfieldlist+'&namefieldlist='+namefieldlist+'&combolist='+combolist+'&sqlstrlist='+sqlstrlist+eval(selectedvalue)+'&wherefieldlist='+wherefieldlist;
	}
	
function addoption(id,value,nama){
		var anOption = document.createElement("OPTION");
		top.document.forms(0).elements(id).options.add(anOption);
		anOption.innerText = nama;
		anOption.value = value;
	}

function PrintPrev(parameter,reportname,outputType){alert('a');
		window.frames['frmMessage'].location='OPHCore/api/msg_print.aspx?defaulttype=1&parameter='+parameter+'&reportname='+reportname+'&OutputType='+outputType;
	}

function changeOutputType(Type){
	document.all.outputtype.value=Type;
	}	
	
function doCombo1(aspfile1, elKeyStr, elIDStr, elNameStr, ComboWhereField) {
		
		
			var sRtn = new Array(10);
    		sRtn[0]	= "0";			//flag
			sRtn[1]	= " ";			//elTarget	//searchtext
			sRtn[2] = " ";			//elName	//pageno
			
			sRtn[3] = "";			//Add-3		//csort
			sRtn[4] = "";			//Add-4		//csortasc
			sRtn[5] = "";			//Add-5		//csortdesc
			sRtn[6] = " ";			//Add-6
			sRtn[7] = " ";			//Add-7
			sRtn[8] = " ";			//Add-8
			sRtn[9] = " ";			//Add-9
			sRtn[10]= " ";			//Add-10
		

  				sRtn = showModalDialog(aspfile1  ,"","center=yes;status=no;help=no;dialogWidth=500pt;dialogHeight=360pt");
				//alert(sRtn);
	
	}
function sendGUID()
{
    var anOption = top.document.forms(0).elements("UserGUID");
	var i;
	for (i = anOption.length - 1; i>=0; i--) {
    if (anOption(i).selected) {
		alert(anOption.options[i].value);
    	window.returnValue = anOption.options[i].value;
    }
  }
	
	window.close();

}

function UploadNow() {
    document.forms(0).submit();
}
function trim(str, chars) {
    return ltrim(rtrim(str, chars), chars);
}

function ltrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}

function rtrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function doReportFunction(functiontext, caption) {
    if (confirm("Do you want to " + functiontext + "?") == 1) {
        document.forms(0).elements("cfunction").value = functiontext;
        document.forms(0).style.cursor = 'wait';
        document.forms(0).submit();
    }
}