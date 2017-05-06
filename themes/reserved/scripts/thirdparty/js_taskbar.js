// JScript File
    
    function tb_resize() {
        var w;
        var x, x1, x2, y1, y2;
        
        x=document.getElementById("frametask");
        x1=document.getElementById("frametaskright");
        x2=document.getElementById("frametaskmid");
        y1=document.getElementById("hiddenframetaskright");
        y2=document.getElementById("hiddenframetaskmid");
        
        if (BrowserDetect.browser=='Explorer' && BrowserDetect.version<=6) {
            x.style.width=document.body.offsetWidth-50;
        }
        else {
            w=x.offsetWidth;
            if (w<500) {
                x1.innerHTML="&nbsp;";
                x1.width="1px";
            }
            else {
                x1.width="184px";
                x1.innerHTML=y1.innerHTML;
                x2.innerHTML=y2.innerHTML;
            }        
            if (w<400) x2.innerHTML="&nbsp;";
            else x2.innerHTML=y2.innerHTML;
        }
    }
    function frametask_onclick()
    {   if (BrowserDetect.browser=='Explorer' && BrowserDetect.version<=6) {
        }
        else {
            var x = document.getElementById("frameapp");
            var x1 = document.getElementById("frametask");
        
            if (x.style.display=="block") {
                x.style.display="none";
                if (x==1) x.className='transON';
            }
            else
                x.style.display="block";

            //x.style.left=(getPos(x1,"Left")-1) + "px";  //x1.offsetLeft-1;
            //x.style.top=(x1.offsetTop-x.offsetHeight+5) + "px";
            
        }
    }

    function frametask_mouseover(){
        if (BrowserDetect.browser=='Explorer' && BrowserDetect.version<=6) {
        }
        else {
            this.className='transOFF';
        }
    }   
    function frametask_mouseout(){
        var x;
        x=document.getElementById("frameapp");
        if (BrowserDetect.browser=='Explorer' && BrowserDetect.version<=6) {
        }
        else {
            if (x.style.display=="none") {
                this.className='transON';
            }
        }
    }

	function initTaskbar()
	{
	    var b=document.getElementById("aspnetForm");
	    //var b=document.body.childNodes[0];
	    var divtask=document.createElement('DIV');
	    divtask.id='frametask';
        x='<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">';
        x+='    <tr><td width="140px" style="background: url(../../../internal/include/images/frametask-title.png) no-repeat;"';
        x+='            onclick="javascript:frametask_onclick();">';
        x+='            &nbsp;';
        x+='        </td>';
        x+='        <td id="frametaskmid" style="background: url(../../../internal/include/images/frametask-repeat.png)">';
        x+='            &nbsp;';
        x+='        </td>';
        x+='        <td width="184px" id="frametaskright" style="background: url(../../../internal/include/images/frametask-repeat.png)">';
        x+='        </td>';
        x+='        <td width="3px" style="background: url(../../../internal/include/images/frametask-right.png)">';
        x+='        </td>';
        x+='    </tr>';
        x+='</table>';
        divtask.innerHTML=x;
	    divtask.className='transON';
	    divtask.onmouseover=frametask_mouseover;
        divtask.onmouseout=frametask_mouseout;
        //divtask.style.height="46px";
        b.appendChild(divtask);

	    var divh1=document.createElement('DIV');
	    divh1.id='hiddenframetaskright';
        
        //<div id="hiddenframetaskright" style="display: none">
        x1='    <table border="0" style="height: 30px; font-size: 12px; color: White; font-family: Arial;"';
        x1+='        width="184px" cellspacing="0" cellpadding="0">';
        x1+='        <tr>';
        x1+='            <td id="OLusr" width="123px" style="background: url(../../../internal/include/images/frametask-status_01.gif) repeat-y;"';
        x1+='                onclick="javascript:chat_onclick();" align="center">';
        x1+='                Online User (1)';
        x1+='            </td>';
        x1+='            <td width="31px">';
        x1+='                <img src="../../../internal/include/images/frametask-status_02.gif" alt="" /></td>';
        x1+='            <td style="width: 30px">';
        x1+='                <img src="../../../internal/include/images/frametask-status_03.gif" alt="" /></td>';
        x1+='        </tr>';
        x1+='    </table>';
        divh1.innerHTML=x1;
	    divh1.style.display='none';
        b.appendChild(divh1);

	    var divh2=document.createElement('DIV');
	    divh2.id='hiddenframetaskmid';

        //<div id="hiddenframetaskmid" style="display: none">
        x2='    <table border="0" width="100%" height="30px" cellspacing="0" cellpadding="0">';
        x2+='        <tr>';
        x2+='            <td>';
        x2+='                &nbsp;';
        x2+='            </td>';
        x2+='        </tr>';
        x2+='    </table>';
        divh2.innerHTML=x2;
	    divh2.style.display='none';
        b.appendChild(divh2);        
        
        
    }

    function getPos(el,sProp) {
        var iPos = 0
        while (el!=null) {
        iPos+=el["offset" + sProp]
        el = el.offsetParent
        }
        return iPos
    } 
    
    function initNow()
    {
        initTaskbar();
        window.onresize = tb_resize;
        tb_resize();
    }


    setTimeout('initNow();',1000);
