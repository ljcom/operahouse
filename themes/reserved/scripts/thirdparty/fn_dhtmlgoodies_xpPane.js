// JScript File

	var xpPanel_slideActive = true;	// Slide down/up active?
	var xpPanel_slideSpeed = 50;	// Speed of slide
	var xpPanel_onlyOneExpandedPane = false;	// Only one pane expanded at a time ?
	
	var dhtmlgoodies_xpPane;
	var dhtmlgoodies_paneIndex;
	
	var savedActivePane = false;
	var savedActiveSub = false;

	var xpPanel_currentDirection = new Array();
	
	var cookieNames = new Array();
	
	
	var currentlyExpandedPane = false;
	
	function Get_Cookie(name) { 
	   var start = document.cookie.indexOf(name+"="); 
	   var len = start+name.length+1; 
	   if ((!start) && (name != document.cookie.substring(0,name.length))) return null; 
	   if (start == -1) return null; 
	   var end = document.cookie.indexOf(";",len); 
	   if (end == -1) end = document.cookie.length; 
	   return unescape(document.cookie.substring(len,end)); 
	} 
	
	function Set_Cookie(name,value,expires,path,domain,secure) { 
		expires = expires * 60*60*24*1000;
		var today = new Date();
		var expires_date = new Date( today.getTime() + (expires) );
	    var cookieString = name + "=" +escape(value) + 
	       ( (expires) ? ";expires=" + expires_date.toGMTString() : "") + 
	       ( (path) ? ";path=" + path : "") + 
	       ( (domain) ? ";domain=" + domain : "") + 
	       ( (secure) ? ";secure" : ""); 
	    document.cookie = cookieString; 
	}

	function cancelXpWidgetEvent()
	{
		return false;		
	}
	
	function showHidePaneContent(e,inputObj)
	{
		if(!inputObj)inputObj = this;
		
		var img = inputObj.getElementsByTagName('IMG')[0];
		var numericId = img.id.replace(/[^0-9]/g,'');
		var obj = document.getElementById('paneContent' + numericId);
		if(img.src.toLowerCase().indexOf('up')>=0)
		{
			currentlyExpandedPane = false;
			img.src = img.src.replace('up','down');
			if(xpPanel_slideActive)
			{
				obj.style.display='block';
				xpPanel_currentDirection[obj.id] = (xpPanel_slideSpeed*-1);
				slidePane((xpPanel_slideSpeed*-1), obj.id);
			}
			else
			{
				obj.style.display='none';
				
            
			}
			if(cookieNames[numericId])Set_Cookie(cookieNames[numericId],'0',100000);
			
							
				if (numericId == 0) 
				{
				    document.getElementById("barPage1").style.display='none';
				}
				else if (numericId == 1) 
				{
				    document.getElementById("barPage2").style.display='none';
				}
				else if (numericId == 2) 
				{
				    top.document.getElementById("barPage3").style.display='none';
				}
				else if (numericId == 3) 
				{
				    top.document.getElementById("barPage4").style.display='none';
				}
				else if (numericId == 4) 
				{
				    top.document.getElementById("barPage5").style.display='none';
				}

		}
		else
		{
			if(this)
			{
				if(currentlyExpandedPane && xpPanel_onlyOneExpandedPane)showHidePaneContent(false,currentlyExpandedPane);
				currentlyExpandedPane = this;	
			}
			else
			{
				currentlyExpandedPane = false;
			}
			img.src = img.src.replace('down','up');
			if(xpPanel_slideActive)
			{
				if(document.all)
				{
					obj.style.display='block';
				}
				xpPanel_currentDirection[obj.id] = xpPanel_slideSpeed;
				slidePane(xpPanel_slideSpeed,obj.id);
                
			}
			else
			{
				obj.style.display='block';
				subDiv = obj.getElementsByTagName('DIV')[0];
				obj.style.height = subDiv.offsetHeight + 'px';
			}
			if(cookieNames[numericId])Set_Cookie(cookieNames[numericId],'1',100000);
			 if (numericId == 0) 
				{
				    document.getElementById("barPage1").style.display='inline';
				}
				else if (numericId == 1) 
				{
				    document.getElementById("barPage2").style.display='inline';
				}
				else if (numericId == 2) 
				{
				    top.document.getElementById("barPage3").style.display='inline';
				}
				else if (numericId == 3) 
				{
				    top.document.getElementById("barPage4").style.display='inline';
				}
				else if (numericId == 4) 
				{
				    top.document.getElementById("barPage5").style.display='inline';
				}
		}	
		return true;	
	}
		
	function slidePane(slideValue,id)
	{
		if(slideValue!=xpPanel_currentDirection[id]){
			return false;
		}
		var activePane = document.getElementById(id);
		if(activePane==savedActivePane){
			var subDiv = savedActiveSub;
		}else{
			var subDiv = activePane.getElementsByTagName('DIV')[0];
		}
		savedActivePane = activePane;
		savedActiveSub = subDiv;
		
		var height = activePane.offsetHeight;
		
		var innerHeight = subDiv.offsetHeight;

        if (slideValue<0) sv=-1*(innerHeight/3);
        else sv=innerHeight/3;
		
		height+=sv;
		if(height<0)height=0;
		if(height>innerHeight) height = innerHeight;
		
		if(document.all){
			activePane.style.filter = 'alpha(opacity=' + Math.round((height / subDiv.offsetHeight)*100) + ')';
		}else{
			var opacity = (height / subDiv.offsetHeight);
			if(opacity==0)opacity=0.01;
			if(opacity==1)opacity = 0.99;
			activePane.style.opacity = opacity;
		}			
		
					
		if(slideValue<0){			
			activePane.style.height = height + 'px';
			subDiv.style.top = height - subDiv.offsetHeight + 'px';
			if(height>0){
				setTimeout('slidePane(' + slideValue + ',"' + id + '")',10);
			}else{
				if(document.all)activePane.style.display='none';
			}
		}else{			
			subDiv.style.top = height - subDiv.offsetHeight + 'px';
			activePane.style.height = height + 'px';
			if(height<innerHeight){
				setTimeout('slidePane(' + slideValue + ',"' + id + '")',10);				
			}
			else
			{   activePane.style.height="auto";
			}		
		}	
	}
	
	function mouseoverTopbar()
	{
		var img = this.getElementsByTagName('IMG')[0];
		var src = img.src;
		img.src = img.src.replace('.gif','_over.gif');
		
		var span = this.getElementsByTagName('SPAN')[0];
		span.style.color='#428EFF';		
		
	}
	function mouseoutTopbar()
	{
		var img = this.getElementsByTagName('IMG')[0];
		var src = img.src;
		img.src = img.src.replace('_over.gif','.gif');		
		
		var span = this.getElementsByTagName('SPAN')[0];
		span.style.color='';
    }
		
	function initDhtmlgoodies_xpPane(panelTitles,panelDisplayed,cookieArray)
	{
		dhtmlgoodies_xpPane = document.getElementById('dhtmlgoodies_xpPane');
		var divs = dhtmlgoodies_xpPane.getElementsByTagName('DIV');
		dhtmlgoodies_paneIndex=0;
		cookieNames = cookieArray;
		for(var no=0;no<divs.length;no++){
			if(divs[no].className=='dhtmlgoodies_panel'){
				
				var outerContentDiv = document.createElement('DIV');	
				var contentDiv = divs[no].getElementsByTagName('DIV')[0];
				outerContentDiv.appendChild(contentDiv);	

				outerContentDiv.id = 'paneContent' + dhtmlgoodies_paneIndex;
				outerContentDiv.className = 'panelContent';
				
				var topBar = document.createElement('DIV');
				topBar.onselectstart = cancelXpWidgetEvent;
				
				
var tr = document.createElement("tr");
var tr2 = document.createElement("tr");
var tr3 = document.createElement("tr");
var t3 = document.createTextNode(" ");

var td = document.createElement("td");
var td2 = document.createElement("td");
var td3 = document.createElement("td");
td3.id='barPage'+(dhtmlgoodies_paneIndex+1);
var td4 = document.createElement("td");


var table_content = document.createElement("table");
table_content.width="100%";
table_content.border="0";

				var span = document.createElement('SPAN');
				span.id='barTitle'+(dhtmlgoodies_paneIndex+1);
				span.innerHTML = panelTitles[dhtmlgoodies_paneIndex];
				var span2 = document.createElement('SPAN');
				span2.id='barCount'+(dhtmlgoodies_paneIndex+1);	
				var span3 = document.createElement('SPAN');
				//span3.id='barPage'+(dhtmlgoodies_paneIndex+1);
				var span4 = document.createElement('SPAN');
				
				td.onclick = showHidePaneContent;
				
				if(document.all)td.ondblclick = showHidePaneContent;
				td.onmouseover = mouseoverTopbar;
				td.onmouseout = mouseoutTopbar;
				//td.style.position = 'relative';

				var img = document.createElement('IMG');
				img.id = 'showHideButton' + dhtmlgoodies_paneIndex;
				img.src = 'OPHCore/images/up.png';				
				
                td.appendChild(span);
                td.appendChild(span2);
                span4.appendChild(img);
                td.appendChild(span4);
                tr.appendChild(td);

//td2.appendChild(t3);
//tr.appendChild(td2);

//td3.appendChild(span3);
tr.appendChild(td3);

table_content.appendChild(tr);
topBar.appendChild(table_content);
			
				if(cookieArray[dhtmlgoodies_paneIndex]){
					cookieValue = Get_Cookie(cookieArray[dhtmlgoodies_paneIndex]);
					if(cookieValue)panelDisplayed[dhtmlgoodies_paneIndex] = cookieValue==1?true:false;
					
				}
				
				if(!panelDisplayed[dhtmlgoodies_paneIndex]){
					outerContentDiv.style.height = '0px';
					contentDiv.style.top = 0 - contentDiv.offsetHeight + 'px';
					if(document.all)outerContentDiv.style.display='none';
					img.src = 'OPHCore/images/down.png';
				}
								
				topBar.className='topBar';
				divs[no].appendChild(topBar);				
				divs[no].appendChild(outerContentDiv);	
				dhtmlgoodies_paneIndex++;			
			}			
		}
	}
	