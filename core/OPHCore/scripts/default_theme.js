var form_added = false, form_edited = false;
var themeXML;

function initTheme(bCode, bGUID, guestID, pageURL, f) { //bmode, bcode, bguid hanya dipakai kalau mau pindah lokasi saja
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();
    if (bCode != undefined) setCookie('code', bCode, 0, 1, 0);
    if (bGUID != undefined && bGUID != null) setCookie('GUID', bGUID, 0, 1, 0);
	if (pageURL != undefined && pageURL!=null) setCookie('page', pageURL, 0, 1, 0);
    var tcode = getQueryVariable('tcode');
    setCookie('guestID', guestID, 7, 0, 0);

    var xmldoc = '';
    try {
        var pathPage = 'index.aspx?mode=' + getMode();
        if (getCode().toLowerCase() === 'dumy')// || getCode().toLowerCase() === '404') // || getCode().toLowerCase() === 'login')
            xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        else
            xmldoc = 'OPHCore/api/default.aspx?mode=master&code=' + getCode() + '&guid=' + getGUID() + '&stateid=' + getState();// + unique;

        if (tcode != undefined)
            xmldoc = xmldoc + '&tcode=' + tcode;

        var divname = ['frameMaster'];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];
        var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage()];

        if (getCode().toLowerCase() !== 'login') {
            var xsldoc1 = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_sidebar';
            $.get(xsldoc1).done(function () {
                divname.push('sidebarWrapper');
                xsldoc.push(xsldoc1);

            }).always(function () {
                pushTheme(divname, xmldoc, xsldoc, true, function (xml) {
                    themeXML = xml;
                });
            });

        }
        else { pushTheme(divname, xmldoc, xsldoc, true); }

    }
    catch (e) {

        showMessage(e.Message, 4, true);
    }

}

function loadThemeFolder() {
    var themeName = document.getElementById('themeName');
    if (themeName != undefined) {
        return themeName.innerHTML;
    } else {
        return getCookie('themeFolder');
    }
}

function getMode() {

    var ret = "browse";
    if (getGUID() && getGUID !== '' && getSearchText() == '') ret = 'form';
    //var mode = getCookie(getCode() + '_mode');
    //if (mode != undefined) ret = mode;
    //else {
    var mode = getQueryVariable('mode') == undefined ? '' : getQueryVariable('mode').toLowerCase();
    if (mode != undefined && mode !== '') ret = mode;
    //}
    return ret;
    //return (getGUID() === '' || getGUID() == undefined) ? 'browse' : 'form'
}


function getCode() { return getQueryVariable("code") == undefined ? getCookie("code") : getQueryVariable("code"); }

function lastCode() { return getCookie('lastCode'); }

function getGUID() { return getCookie('GUID') == undefined || getCookie('GUID') === "" ? getQueryVariable("GUID"):getCookie("GUID") ; }

function getPage() {
    var pageName = document.getElementById('pageName');
    if (pageName != undefined) {
        return pageName.innerHTML;
    } else {
        return getCookie('page');
    }
}

function getState() { return getQueryVariable("stateid") == undefined ? getCookie(getCode().toLowerCase() + '_curstateid') : getQueryVariable("stateid"); }

function changestateid(stateid) {
    setCookie('stateid', stateid);
    setCookie(getCode().toLowerCase() + '_curstateid', stateid);
    //setCookie('bSearchText', getSearchText());
    var searchvalue = $('#searchBox').val();
    setCookie('bSearchText', searchvalue, 0, 1, 0);
    loadContent(1);
}


function getSearchText() {
    return getCookie('bSearchText') == undefined || getCookie('bSearchText') == '' ?
        (getQueryVariable("bSearchText") == undefined ? '' : getQueryVariable("bSearchText")) : getCookie('bSearchText');
}

function getOrder() {
    if (getCookie("sortOrder") == undefined || getCookie("sortOrder") === "") {
        if (getQueryVariable("sortOrder") == undefined || getQueryVariable("sortOrder") === "") {
            return "";
        } else {
            return getQueryVariable("sortOrder");
        }
    } else {
        return getCookie("sortOrder");
    }
    //return (getQueryVariable("sortOrder") == undefined ? (getCookie("sortOrder") == undefined ? "" : getCookie("sortOrder")) : getQueryVariable("sortOrder"))
}

function getFilter() {
    if (getCookie("sqlFilter") == undefined || getCookie("sqlFilter") === "") {
        if (getQueryVariable("sqlFilter") == undefined || getQueryVariable("sqlFilter") === "") {
            return "";
        } else {
            return getQueryVariable("sqlFilter");
        }
    } else {
        return getCookie("sqlFilter");
    }
    //return (getQueryVariable("sqlFilter") == undefined ? (getCookie("sqlFilter") == undefined ? "" : getCookie("sqlFilter")) : getQueryVariable("sqlFilter"))
}

function getUnique() {
    var d = new Date(),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = '' + d.getFullYear(),
        h = '' + d.getHours(),
        n = '' + d.getMinutes(),
        s = '' + d.getSeconds();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    if (h.length < 2) h = '0' + h;
    if (n.length < 2) n = '0' + n;
    if (s.length < 2) s = '0' + s;

    return [year, month, day, h, n, s].join('');
}

//interface
var scrollLoad=false;
function loadContent(nbpage, isLoadSidebar, f) {
    
	if(isLoadSidebar==undefined) isLoadSidebar=true;
	
	var xmldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();
    var rows = getQueryVariable('brows');
    if (rows == undefined) rows = '20';
    setCookie(getCode().toLowerCase()+'_curPage', nbpage, 1, 0, 0);
    setCookie(getCode().toLowerCase()+'_TotalPages', nbpage, 1, 0, 0);

    //main content
    if (lastCode() !== getCode()) {
        setCookie('sqlFilter', "", 0, 0, 0);
        setCookie('sortOrder', "", 0, 0, 0);
        setCookie('lastCode', getCode(), 0, 0, 15);
    }
    if (getCode().toLowerCase() === 'dumy')
        xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else
        xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&sortOrder=' + getOrder() + unique;

    var view = '_' + getCookie(getCode() + '_view');
    if (view == undefined || view == '_' || view == '_null') view = '';

    //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];
    var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode()];

    var divname = ['contentWrapper'];

    //sidebar only for form
    var showDocInfo = getCookie(getCode().toLowerCase() + '_showdocinfo');
    if (getMode() === 'form' && showDocInfo == 1 && isLoadSidebar) {
		if ($('#sidebarWrapper').html()!=null) {
			divname.push('sidebarWrapper');
			var xsldoc1 = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode() + '_sidebar';
			xsldoc.push(xsldoc1);
		}
	}
    else {
		if ($('#chatMessages').html()!=null) {
			divname.push('chatMessages');
			//var xsldoc1 = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode() + '_sidebar';
			var xsldoc1 = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/_form_talk.xslt';
			xsldoc.push(xsldoc1);
		}
		
		if ($('#docInfoPanel').html()!=null) {
			divname.push('docInfoPanel');
			//var xsldoc1 = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode() + '_sidebar';
			var xsldoc2 = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/_form_info.xslt';
			xsldoc.push(xsldoc2);
		}
        window.addEventListener("scroll", function (event) {
            
            if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight*0.8 && !scrollLoad) {
                // you're at the bottom of the page
                scrollLoad=true;
                var nbpage=getCookie(getCode().toLowerCase()+'_curPage');
                var totalPages=getCookie(getCode().toLowerCase()+'_TotalPages');
                if (parseInt(nbpage)<parseInt(totalPages)) {
                    nbpage++;
                    console.log('load '+nbpage);
                    var divname = ['browseContent'];
                    var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode()];
                    var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&sortOrder=' + getOrder() + unique;
                    pushTheme(divname, xmldoc, xsldoc, false, function() {
                        setCookie(getCode().toLowerCase()+'_curPage', nbpage, 1, 0, 0);
                        scrollLoad=false;
                    });
                }
            }
        });
    };
    setTimeout(function () { pushTheme(divname, xmldoc, xsldoc, true); }, 100);
}

function loadChild(code, parentKey, GUID, pageNo, mode, pcode) {
    var xmldoc;
    var xsldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

	if (!cell_added && !cell_changed) {
		if (parentKey == undefined) {
			parentKey = getCookie(code.toLowerCase() + '_parentKey');
			GUID = getCookie(code.toLowerCase() + '_parentGUID');
			mode = getCookie(code.toLowerCase() + '_browseMode');
			pcode = getCookie(code.toLowerCase() + '_pcode');
		}
		else {
			setCookie(code.toLowerCase() + '_parentKey', parentKey);
			setCookie(code.toLowerCase() + '_parentGUID', GUID);
			setCookie(code.toLowerCase() + '_pcode', pcode);
			setCookie(code.toLowerCase() + '_browseMode', mode);
		}
		if (GUID==null) GUID=$('#cid').val();
		d = '<div><div class="box box-solid box-default child" data-code="'+code+'" data-parentKey="'+parentKey+'" data-guid="'+GUID+'" data-mode="'+mode+'" style="box-shadow:0px;border:none" id="child' + code + GUID.toLowerCase() + '"></div></div>';
		if ($('#child' + code + GUID.toLowerCase()).length == 0) {
			$('#tr2_' + pcode + GUID.toLowerCase()).children("td").append(d);
		}
		pageNo = pageNo == undefined ? 1 : pageNo;

		xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + unique;

		var divName = ['child' + String(code).toLowerCase() + GUID.toLowerCase()];
		if (mode === 'inline')
			xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + code + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_childInline'+(getMode()=='studio'?'_studio':'')];
		else if (mode != undefined && mode.indexOf('custom') >= 0)
			xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + code + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + mode+(getMode()=='studio'?'_studio':'')];
		else if (mode != undefined && mode != '')
			xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + code + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_child' + mode+(getMode()=='studio'?'_studio':'')];
		else if (mode === 'tree')
			xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + code + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_tree' + mode+(getMode()=='studio'?'_studio':'')];
		else
			xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + code + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_childBrowse'+(getMode()=='studio'?'_studio':'')];

		pushTheme(divName, xmldoc, xsldoc, true);

		//$('#' + code).on('show.bs.collapse', '.collapse', function () {
		//    $('#' + code).find('.collapse.in').collapse('hide');

		//});

		//showXML(divName, xmldoc, xsldocs, true, true, function () { });
	}
}

function reloadChild(tabno) {
	$.each($("#tab_"+tabno).find(".child"), function(i, x) {
		loadChild($(x).data("code"));
	});
}


function loadBrowse(bCode, searchText, f) {
    //OPH4 --refreshHeader
    //evn=back harus di revisi
    if (searchText)
        var url = "index.aspx?code=" + bCode + '&bSearchText=' + searchText;
    else
        var url = "index.aspx?code=" + bCode;
    goTo(url);
    //document.location = url;
}


function changeSumField(rowno) {
    var TableSumfield, field, index, result;
    result = "";
    TableSumfield = eval('document.all.SumField.innerHTML');
    do {
        index = TableSumfield.indexOf("SumFormula_");
        if (index <= 0)
            break;
        TableSumfield = TableSumfield.substring(index + 11, TableSumfield.length);
        field = TableSumfield.substring(0, TableSumfield.indexOf('>'));
        if (field.indexOf(' ') > 0) {
            field = field.substring(0, field.indexOf(' '));
        }
        if (field !== "")
            result += 'window.document.all.ReadOnly' + field + rowno + '.innerText=eval(window.document.all.SumFormula_' + field + '.value),';
    }
    while (index > 0);
    return result;
}

function loadReport(qCode, f) {
    var xmldoc;
    var xsldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    qCode = (qCode === "") ? getCode() : qCode;
    //tcode = (tcode == undefined) ? getQueryVariable("tcode") : tcode;
    xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + unique;    //+ ((tcode != undefined) ? '&tcode=' + tcode : '') + unique;
    //xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '.xslt';
    xsldoc = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=report_' + getMode();
    showXML('contentWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f === "function") f();
    });

    //xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + ((tcode != undefined) ? '&tcode=' + tcode : '') + '&GUID=' + getGUID() + unique;
    //xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '_sidebar.xslt';
    //var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();
    //showXML('sidebarWrapper', xmldoc, xsldoc, true, true, function () {
    //if (typeof f === "function") f();
    //});

}





//childform

function showChildForm(code, guid, parent) {
    var divnm = [code + guid.toLowerCase()];
    //clear other childform
    if (!$('#' + code + guid.toLowerCase()).is(":visible")) {

        $("#" + divnm).html("Please Wait...");

        var xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=form&GUID=" + guid.toLowerCase();

        //var xsldoc = ["OPHContent/themes/" + loadThemeFolder() + "/xslt/" + getPage() + "_childForm.xslt"];
        var xsldoc = ["OPHContent/themes/" + loadThemeFolder() + "/xslt/" + getPage() + "_childForm.xslt"];
        pushTheme(divnm, xmldoc, xsldoc, true, function () {
            $('#' + code + guid.toLowerCase()).collapse('show');
            var form = 'form' + code;

        });
        //$('#' + code).find('.collapse.in').collapse('hide');
        //$('#' + code).children().find('.collapse.in').collapse('hide');
        $('#' + code + guid.toLowerCase()).parent().parent().parent().children().find('.collapse.in').collapse('hide');
    }
    else {
        $('#' + code + guid.toLowerCase()).collapse({ parent: '#' + guid, toggle: true });
        $('#' + code + guid.toLowerCase()).collapse('toggle');
        $("#" + divnm).html("");
    }

}
function closeChildForm(code, guid) {
    var arGUID;

    var divnm = [code + guid.toLowerCase()];
    $('#' + divnm).collapse("hide");
}

//functions

function btn_function(code, GUID, action, page, location, formId, comment, afterSuccess, ini) {
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, browse anak:30, browse form:40
    $(ini).button('loading');
    var pg = (page === "" || isNaN(page)) ? 0 : parseInt(page);

    if (location == undefined || location === "") { location = 20; }

    if (action === "formView") {
        loadForm(code, GUID);
    } else if (action === "save") {
        //location: 0 header; 1 child; 2 browse 
        //location: browse:10, header form:20, browse anak:30, browse form:40
        var r = saveFunction(code, GUID, location, formId, function () {
            if (typeof afterSuccess === "function") afterSuccess(data);
            $(this).button('reset');
        });
        if (!r) $(ini).button('reset');
    } else {
        if (GUID === null || GUID === '') {
            if (isIE()) {
                arGUID = [].slice.call($("input:checked").not("#pinnedAll").map(function () { return this.dataset.guid; }));
            } else {
                arGUID = Array.from($("input:checked").not("#pinnedAll").map(function () { return this.dataset.guid; }));
            }
            GUID = arGUID.join();
        }

        var r = executeFunction(code, GUID, action, location, null, null, comment, function (data) {
            if (typeof afterSuccess === "function") afterSuccess(data);
            $(ini).button('reset');
        });
        if (!r) $(ini).button('reset');
    }
}

function b64toBlob(b64Data, contentType, sliceSize) {
    contentType = contentType || '';
    sliceSize = sliceSize || 512;

    var byteCharacters = atob(b64Data);
    var byteArrays = [];

    for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
        var slice = byteCharacters.slice(offset, offset + sliceSize);

        var byteNumbers = new Array(slice.length);
        for (var i = 0; i < slice.length; i++) {
            byteNumbers[i] = slice.charCodeAt(i);
        }

        var byteArray = new Uint8Array(byteNumbers);

        byteArrays.push(byteArray);
    }

    var blob = new Blob(byteArrays, { type: contentType });
    return blob;
}

function saveFunction(code, guid, location, formId, afterSuccess, beforeStart) {
    return saveFunction1(code, guid, location, formId, null, afterSuccess, beforeStart);
}

function saveFunction1(code, guid, location, formId, dataFrm, afterSuccess, beforeStart, saveFlag) {
	var valid = false;

    var tblnm = code;
    var data;
	if (formId==undefined || formId=='') formId='formheader';
    requiredname = document.getElementsByName(tblnm + "requiredname")[0];
    var result;
    var idReq;
    if (requiredname != undefined && dataFrm == null) {
        var requirednamev = requiredname.value;

        if (requirednamev !== '' && requirednamev != undefined) {
            result = checkrequired(requirednamev.split(', '), location == 30 ? guid : '', 'good');
            idReq = checkrequired(requirednamev.split(', '), location == 30 ? guid : '', 'id');
        } else {
            result = 'good';
        }
    } else {
        result = 'good';
    }

    if (dataFrm != "" && dataFrm != null) {
        var A = dataFrm.split("&");
        var C = '';
        if (requiredname) C = requiredname.value.replace(/\s/g, '').split(",");
        A.forEach(function (a, b) {
            var x = a.split("=");
            var ix = x[0];
            var val = x[1];

            for (j = 0; j < C.length; j++) {
                if (C[j] == ix && val == "") {
                    result = ix + " need to be filled";
                }
            }
        });
    }

    if (result === 'good') {
        if (dataFrm === null) {
            data = new FormData();
            var thisForm = (formId != undefined) ? '#' + formId : 'form';

            $.each($(':file'), function (key, value) {
                $.each(value.files, function (key, value) {
                    data.append(key, value);
                });
            });

            $(".oph-webcam").each(function () {
                var valtxt = $(this).val();

                var ImageURL = valtxt;
                if (ImageURL) {
                    var block = ImageURL.split(";");
                    if (block.length > 1) {
                        var contentType = block[0].split(":")[1];
                        var realData = block[1].split(",")[1];

                        // Convert it to a blob to upload
                        var blob = b64toBlob(realData, contentType);

                        //                    var fileOfBlob = new File([blob], 'test.jpg');
                        data.append("test", blob, 'foto.jpg');
                        $(this).val("foto.jpg");
                    }
                }
            });

            if (location == 30) { //child and gchildren
                //move to celljs
            } else {
                $.each($('form'), function (key, f) {
                    var other_data = $(f).serializeArray();
                    $.each(other_data, function (key, input) {
                        var newVal = input.value;
                        if (newVal) {
                            newVal = newVal.replace(/</g, '&lt;');
                            newVal = newVal.replace(/>/g, '&gt;');
                        }
                        else
                            console.log(input.name);
						
						if (input.name == "cid" && $("#PK" + code.toLowerCase()).val() != undefined)
							data.append("cid", $("#PK" + code.toLowerCase()).val());
						else
							data.append(input.name, newVal);
                    });
                });
            }
        }
        else {
            data = new FormData();
            dataFrm.split('&').forEach(function (i) {
                d = i.split('=');
                var newVal = d[1];
                if (newVal) {
                    newVal = newVal.replace(/</g, '&lt;');
                    newVal = newVal.replace(/>/g, '&gt;');
                }
                else console.log(d[0]);
                data.append(d[0], newVal);
            });
        }
		
		
        
		
        data.append('mode', 'save');
        data.append('cfunctionlist', guid);
        data.append('unique', $("#unique").val());


        if (typeof beforeStart === "function") {
            //sdata = $(data).serialize();
            valid = beforeStart(data);
			if (valid==undefined) valid=true;
        }
		else valid = true;

        if (valid)
            $.ajax({
                type: "POST",
                url: "OPHCore/api/default.aspx?code=" + code,
                enctype: 'multipart/form-data',
                cache: false,
                contentType: false,
                processData: false,
                data: data,
                success: function () {
                    //alert("Data Uploaded: ");
                }
            }).done(function (data) {
                var msg = $(data).children().find("message").text();
                var u = $(data).children().find("unique").text();
                if (u) $("#unique").val(u);
                // showMessage('Saving is successfully.', 2);
				form_edited=false;
				form_added=false;
                if (typeof afterSuccess === "function") afterSuccess(data);
            });
    }
    else {
        if (location == 50 || location === '50') { //saveModalForm
            $('#notiModal').data("message", result);
            $('#notiModal').data("colname", idReq);
            if (typeof afterSuccess === "function") afterSuccess(result);
        } else if ((location == 30 || location === '30') && (saveFlag == 1 || saveFlag === '1')) {
            return
        } else {
            if (idReq) showMessage(result, '0', idReq, function () { });
            else showMessage(result, 0, null, function () {
                if (typeof afterSuccess === "function") afterSuccess(result);
            });
        }

    }
	return valid;

}

function preview(flag, code, GUID, formid, t) {

    previewFunction(flag, code, GUID, formid, null, t);

}

function previewFunction(flag, code, GUID, formid, dataFrm, t, afterSuccess) {
    if (flag == undefined) flag = 1;
    if (GUID == undefined) GUID = "00000000-0000-0000-0000-000000000000";
    if (flag > 0) {

        var dataForm = new FormData();
        if (formid != undefined) {
            thisForm = '#' + formid
			if (thisForm =='#') thisForm = "form";
            dataFrm = $(thisForm).serialize();
        }
        if (!!dataFrm) {
            dataFrm.split('&').forEach(function (i) {
                d = i.split('=');
                var newVal = d[1];
                if (newVal) {
                    newVal = newVal.replace(/</g, '&lt;');
                    newVal = newVal.replace(/>/g, '&gt;');
                    dataForm.append(d[0].toString(), d[1].toString());
                }
            });
        } else {
            $.each($('form'), function (key, f) {
                var other_data = $(f).serializeArray();
                $.each(other_data, function (key, input) {
                    var newVal = input.value;
                    newVal = newVal.replace(/</g, '&lt;');
                    newVal = newVal.replace(/>/g, '&gt;');
                    dataForm.append(input.name, newVal);
                });
            });

        }

        dataForm.append('mode', 'preview');
        dataForm.append('flag', flag);
        dataForm.append('cfunctionlist', GUID);

        var path = 'OPHCore/api/default.aspx?code=' + code;
        var thisForm = 'form';

        $.ajax({
            url: path,
            data: dataForm,
            type: 'POST',
            enctype: 'multipart/form-data',
            cache: false,
            contentType: false,
            processData: false,
            //dataType: "xml",
            timeout: 80000,
            beforeSend: function () {
                //setCursorWait(this);
            },
            success: function (data) {
                var x = $(data).find("message").children().each(function () {
                    //$(this).text();
					if (this.tagName=='infoMsg') {
						showMessage($(this).text(), '1', true);
					}
					else if (this.tagName=='successMsg') {
						showMessage($(this).text(), '2', true);
					}
					else if (this.tagName=='errMsg') {
						showMessage($(this).text(), '4', true);
					}
					else if (document.getElementById("cb"+this.tagName)) {
                        if (document.getElementById("cb"+this.tagName).type === "checkbox") {
                            if ($(this).text() === "1") {
                                document.getElementById("cb"+this.tagName).checked = true;
                                document.getElementById(this.tagName).value = 1;
                            } else {
                                document.getElementById("cb"+this.tagName).checked = false;
                                document.getElementById(this.tagName).value = 0;
                            }
                        } 
					}
					else if (document.getElementById(this.tagName)) {
						if (flag > 1 || $(this).text() !== '') {

							if (document.getElementById(this.tagName).type === 'select-one') {
								var checktext; 
								if ($(this.nextSibling)[0]!=undefined) checktext = $(this.nextSibling)[0].tagName;
								if (checktext === this.tagName + '_name') {
									var newOption = new Option($(this.nextSibling).text(), $(this).text(), true, true);
									$("#" + this.tagName).append(newOption).trigger('change');
								} else {
									var defer = [];
									autosuggest_setValue(defer, this.tagName, code, this.tagName, this.textContent);
								}
							} else if (document.getElementById(this.tagName).type != undefined && document.getElementById(this.tagName).type != '') {
								document.getElementById(this.tagName).value = $(this).text();
							} else {
								document.getElementById(this.tagName).innerHTML = $(this).text();
							}

						}
						if ($(this).attr('display') === 'show') {
							if ($('[name=' + this.tagName + ']').data("type") === 'dateBox')
								$('[name=' + this.tagName + ']').parent().parent().show();
							else
								$('[name=' + this.tagName + ']').parent().show();
						}
						else if ($(this).attr('display') === 'hide' || $(this).attr('display') === 'none') {
							if ($('[name=' + this.tagName + ']').data("type") === 'dateBox')
								$('[name=' + this.tagName + ']').parent().parent().hide();
							else
								$('[name=' + this.tagName + ']').parent().hide();
						}

						if ($(this).attr('readonly') === 'true' || $(this).attr('readonly') === '1') {
							$('[name=' + this.tagName + ']').parent().removeClass('enabled-input').addClass('disabled-input');
							$('[name=' + this.tagName + ']').parent().attr('disabled', 'disabled');
						}
						if ($(this).attr('readonly') === 'false' || $(this).attr('readonly') === '0') {
							$('[name=' + this.tagName + ']').parent().removeClass('disabled-input').addClass('enabled-input');
							$('[name=' + this.tagName + ']').parent().removeAttr('disabled');
						}

						if ($(this).attr('style')) {
							var style = $(this).attr('style');
							$('[name=' + this.tagName + ']').parent().attr('style', style);
						}
					}
					else if (document.getElementsByName(this.tagName).length>0) {
						if (document.getElementsByName(this.tagName)[0].type==="radio") {
							if ($(this).text()=="") {
								//reset
								n=document.getElementsByName(this.tagName).length;
								for (var g=0;g<n;g++) {
									document.getElementsByName(this.tagName)[g].checked=false;
								}
							}
							else {
								var g=$(this).text();
								if ($(this).text()[g]) $(this).text()[g].checked=true;
							}
						}
					}						
					//EndBy eLs updated by samuel 20180808
					
                    

                    //AddedBy eLs for : master browse inline child preview
                    var select2Tag = '#' + this.tagName + '_' + GUID;
                    var otherTag = "#tr1_" + code.toLowerCase() + GUID + " > td[data-field$='" + this.tagName + "']";
                    var val = this.textContent;
                    if ($(select2Tag).length > 0) {
                        var selectID = this.tagName + "_" + GUID;
                        if (val) autosuggest_setValue(undefined, selectID, code, this.tagName, val, '', '');

                        if (this.getAttribute('readonly') == "true") {
                            $(select2Tag).prop("disabled", true);
                            $(otherTag + ">span").hide();
                        }
                        else {
                            $(select2Tag).prop("disabled", false);
                            $(otherTag + ">span").show();
                        }
                    } else {
                        if (val) $(otherTag).text(val);

                        if (this.getAttribute('readonly') == "true") {
                            $(otherTag).attr("contenteditable", "false");
                            $(otherTag).removeAttr('tabindex');
                            $(':focus').blur();
                        }
                        if (this.getAttribute('readonly') == "false") {
                            $(otherTag).attr("contenteditable", "true");
                            $(otherTag).attr("tabindex", "1");
                        }

                        if (this.getAttribute('readonlyAll') == "true") {
                            $("td[data-field$='" + this.tagName + "']").attr("contenteditable", "false");
                            $("td[data-field$='" + this.tagName + "']").removeAttr('tabindex');
                            $(':focus').blur();
                        }
                        if (this.getAttribute('readonlyAll') == "false") {
                            $("td[data-field$='" + this.tagName + "']").attr("contenteditable", "true");
                        }

                    }

                    if (typeof afterSuccess === "function") afterSuccess(data);

                });
            }
        });
    }
    else {
        checkChanges(t);
    }
}
function checkChanges(t, force) {
    if (t) {
        var curdata = '';
        var olddata = $(t).data("old") == undefined ? "" : $(t).data("old");
        if (t.id!='' && ($("#" + t.id).prop("type") === "select-one") && (t.options[t.selectedIndex].value !== $("#" + t.id).data("value"))) {
            curdata = t.options[t.selectedIndex].value;
            //$("#" + t.id).data("value", t.options[t.selectedIndex].value);
        }
        else if ($(t).hasClass("cell-editor-textbox") || $(t).hasClass("cell-editor-datepicker"))
            curdata = $(t).html();
        else if ($(t).data("webcam") == '1') {
            var img = $(t).data("field");
            olddata = $("#CapturedImage_hidden_div").find("img").attr("src");
            curdata = $("#CapturedImage_camera").find("img").attr("src");

        }
        else
            curdata = $(t).val();

        if (curdata !== olddata || force) {
            if ($(t).data("child") === 'Y') {
                $('#child_button_addSave').show();
                $('#child_button_save').show();
                $('#child_button_cancel').show();
                $('#child_button_delete').hide();
                $('#child_button_save2').show();
                $('#child_button_cancel2').show();
                $('#child_button_delete2').hide();
            }
            else {
                $('#button_save').show();
                $('#button_cancel').show();
                $('#button_submit').hide();
                $('#button_delete').hide();
                $('#button_approve').hide();
                $('#button_reject').hide();
                $('#button_close').hide();
                $('#button_save2').show();
                $('#button_cancel2').show();

                $('.action-save').show();
                $('.action-cancel').show();
                $('.action-submit').hide();
                $('.action-delete').hide();
                $('.action-approve').hide();
                $('.action-reject').hide();
                $('.action-close').hide();

            }
            form_edited = true;
        }


    }
}


function saveConfirm() {
    // kykny tdk perlu di validasi lg, krn sudah di validasi sebelumny di checkChanges

    //$("input[type='text'], input[type='checkbox'], select").each(function () {
    //    var t = $(this);
    //    if ($(this).data("old") != undefined) {

    //        if ((t.prop("type") === "text" || t.prop("type") === "checkbox") && ($(this).val() !== $(this).data("old")) ||
    //            ((t.prop("type") === "select-one") && ($(this).data("value") !== $(this).data("old")))) {

    //            if (t.prop("type") === "text" || t.prop("type") === "checkbox") $(this).data("old", $(this).val());
    //            if (t.prop("type") === "select-one") {
    //                $(this).data("old", $(this).data("value"));
    //                $(this).data("oldtext", t[0].options[t[0].selectedIndex].text);
    //            }
    //            $('#button_save').hide();
    //            $('#button_cancel').hide();
    //            $('#button_save2').hide();
    //            $('#button_cancel2').hide();
    //        }
    //    }
    //})
    $('#button_save').hide();
    $('#button_cancel').hide();
    $('#button_submit').show();
    $('#button_delete').show();
    $('#button_approve').show();
    $('#button_reject').show();
    $('#button_close').show();
    $('#button_save2').hide();
    $('#button_cancel2').hide();

    $('.action-save').hide();
    $('.action-cancel').hide();
    $('.action-submit').show();
    $('.action-delete').show();
    $('.action-approve').show();
    $('.action-reject').show();
    $('.action-close').show();
}


function saveCancel() {
    if (getGUID() === "00000000-0000-0000-0000-000000000000") back();
    else {
        $("input[type='text'], input[type='checkbox'], input[type='file'], textarea, select").each(function () {
            var t = $(this);
            if (t.data("webcam") == "1") {
                var d = t.data("field");
                var imgsrc = $("#" + d + "_hidden_div").find("img").prop("src");
                $("#" + d + "_camera").find("img").prop("src", imgsrc);
            }
            if ($(this).data("old") != undefined) {

                if ((t.prop("type") === "text" || t.prop("type") === "checkbox") && $(this).val() !== $(this).data("old") ||
                    t.prop("type") === "select-one" && $(this).data("value") !== $(this).data("old")) {

                    if (t.prop("type") === "text") $(this).val($(this).data("old"));
                    if (t.prop("type") === "checkbox") t.prop('checked', $(this).data("old"));
                    if (t.prop("type") === "select-one") $(this).data("value", $(this).data("old"));


                    //select
                    var newOption = new Option($(this).data("oldtext"), $(this).data("old"), true, true);
                    t.append(newOption).trigger('change');

                    //token
                    if ($(this).data("type") === 'tokenBox') {
                        var tokenCode = $(this).data("code");
                        var key = $(this).data("key");
                        var id = $(this).data("id");
                        var name = $(this).data("name");
                        var search = $(this).data("old");

                        var cURL = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=' + tokenCode + '&key=' + key + '&id=' + id + '&name=' + name + '&parentCode=' + getCode() + '&search=' + search;
                        var fieldName = $(this)[0].id;
                        $.ajax({
                            url: cURL,
                            dataType: 'json',
                            success: function (data) {
                                //var xx = '';
                                $("#" + fieldName).tokenInput("clear");
                                $.each(data, function (i, item) {
                                    $("#" + fieldName).tokenInput("add", data[i]);
                                    //xx += data[i].id + '*';
                                });
                                //$("#" + fieldName).val(xx);

                                simplyCancel();
                                //$tokenInput(get, '');
                            }
                        });
                    }

                    simplyCancel();
                }
            } else {
                simplyCancel();
            }
        });
        form_edited = false;
    }
}
function simplyCancel() {
    $('#button_save').hide();
    $('#button_cancel').hide();
    $('#button_submit').show();
    $('#button_delete').show();
    $('#button_approve').show();
    $('#button_reject').show();
    $('#button_close').show();
    $('#button_save2').hide();
    $('#button_cancel2').hide();

    $('.action-save').hide();
    $('.action-cancel').hide();
    $('.action-submit').show();
    $('.action-delete').show();
    $('.action-approve').show();
    $('.action-reject').show();
    $('.action-close').show();
}
function executeFunction(code, GUID, action, location, approvaluserguid, pwd, comment, afterSuccess, beforeStart) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    if (approvaluserguid != undefined || approvaluserguid != null) { pwd = document.getElementById("txtpwd" + approvaluserguid).value; }

    //add parameter approvaluserguid and pwd
    //location: browse:10, header form:20, header sidebar: 21, browse anak:30, browse form:40
    var successmsg = '', isAction = true;
    var docState = getCookie(code.toLowerCase() + '_curstateid');

    if (action === 'execute') {
        if (docState === "" || docState === "0") {
            successmsg = 'Submited Succesfully';
            isAction = confirm("You are about to Submit this record. Are you sure?");
        }
        else if (docState === '300') {
            successmsg = 'Re-Submited Succesfully';
            isAction = confirm("You are about to Re-Submit this record. Are you sure?");
        }
        else {
            successmsg = 'Approve Succesfully';
            isAction = confirm("You are about to Approve this record. Are you sure?");
        }
    } else if (action === 'force') {
        if (docState >= '400') {
            successmsg = 'Close/Archive Succesfully';
            isAction = confirm("You are about to Close/Archive this record. Are you sure?");
        }
        else {
            successmsg = 'Rejected Succesfully';
            isAction = confirm("You are about to Reject this record. Are you sure?");
        }
    } else if (action === 'reopen') {
        successmsg = 'Reopen Succesfully';
    } else if (action === 'inactivate') {
        successmsg = 'Inactivate Succesfully';
        isAction = confirm("You are about to " + action + " this record. Are you sure?");
        action = "delete";
    } else if (action === 'delete') {
        successmsg = 'Delete Succesfully';
        isAction = confirm("You are about to " + action + " this record. Are you sure?");
    } else if (action === 'restore') {
        successmsg = 'Restore Succesfully';
    } else if (action === 'wipe') {
        successmsg = 'Wipe Succesfully';
        isAction = confirm("You are about to " + action + " this record. Are you sure?");
    }
    else if (action != '') {
        successmsg = action + ' Succesfully';
        isAction = confirm("You are about to " + action + " this record. Are you sure?");
    }

    if (action === "delete" && location == 40) {
        if (isAction == 1) {
            preview(1, code, GUID, "form" + code, null);
        }
    }
    //add approvaluserguid and pwd and comment
    //var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment=' + comment + '&approvaluserguid=' + approvaluserguid + '&pwd=' + pwd + unique;
    var path = 'OPHCore/api/default.aspx?code=' + code + unique;

    if (location == undefined || location === "") { location = 20; }
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, header sidebar: 21, browse anak:30, browse form:40


    if (typeof beforeStart === "function") {
        //sdata = $(data).serialize();
        isAction = beforeStart(data);
    }

    if (isAction == 1) {
        var frmData = new FormData();
        frmData.append('mode', 'function');
        frmData.append('cfunction', action);
        frmData.append('cfunctionlist', GUID);
        frmData.append('comment', comment);
        frmData.append('approvaluserguid', approvaluserguid);
        frmData.append('pwd', pwd);
        frmData.append('unique', $("#unique").val());

        $.ajax({
            type: "POST",
            url: path,
            enctype: 'multipart/form-data',
            cache: false,
            contentType: false,
            processData: false,
            data: frmData,
            success: function (data) {
                var msg = $(data).find('message').text();
                var reload = $(data).find('reload').text();
                if (msg === '' || msg === 'Approval Succesfully' || msg.substring(0, 1) === '2') {
                    //location: 0 header; 1 child; 2 browse 
                    //location: browse:10, header form:20, browse anak:30, browse form:40
                    //if ($("#tr1_" + code + GUID) && location !== '10' && action === "delete") {
                    if (action === "delete" && (location == 30 || location == 40)) {
                        var g = GUID.split(",");
                        g.forEach(function (i) {
                            $("#tr1_" + code + i.toLowerCase()).remove();
                            $("#tr2_" + code + i.toLowerCase()).remove();
                        });
                    }
                    else {
                        if (action === 'delete' && location == 20) {
                            //location: 0 header; 1 child; 2 browse 
                            //location: browse:10, header form:20, header sidebar:21, browse anak:30, browse form:40

                            //window.location = 'index.aspx?code=' + getQueryVariable("code");
                            showMessage(successmsg, '2', true, function () {
                                loadBrowse(code);
                            });
                            loadBrowse(code);

                        }
                        //if (action === 'execute' && location == 21) {
                        //		//refresh sidebar
                        //                   loadContent(1);
                        //                   showMessage(successmsg);
                        //}
                        else {
                            //showMessage(successmsg);
                            //loadContent(1);
                            showMessage(successmsg, '2', true, function () {

                            });
                            setTimeout(function () {
                                if (reload == '1') loadBrowse(code);
                                else loadContent(1);    //why need this?
                            }, 2000);

                        }

                        //window.location.reload();
                    }
                }
                else {
                    //loadContent(1);   //why need this?
                    showMessage(msg, 3);
                    setTimeout(function () { loadContent(1); }, 2000);
                }

                if (typeof afterSuccess === "function") afterSuccess(data);
            }
        });

    }
    return isAction;
}

function downloadModule(code, exportMode, withData) {
    window.open('OPHCore/api/msg_rptDialog.aspx?code=' + code + '&mode=parent&exportMode=' + exportMode + '&withdata=' + withData);
}


function downloadChild(code, t) {
    //var titleName = '';
    //var subtitleName = '';
	ParentGUID=$('#filter'+code.toLowerCase()).val().split('=')[1].split('\'').join('');
    //ParentGUID = $(t).parent().parent().parent().parent().parent().parent().parent().data("parentguid");
    if (ParentGUID == undefined) ParentGUID = getGUID();

    //window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&code=' + code + '&parameter=&outputType=3&' + ParentGUID + '&titleName=' + titleName + '&subtitleName=' + subtitleName + ' ' + Date());
    window.open('OPHCore/api/msg_rptDialog.aspx?mode=child&code=' + code + '&parentGUID=' + ParentGUID);
}


//other

function storeHash(code, anchor) {
    setCookie('hash_' + code, anchor, 1);
}
function getHash(code) {
    hash = getCookie('hash_' + code);
	
    if (hash !== '') {
        //alert(hash);
        $('a[href*="' + hash + '"]').trigger('click');

        //$('a.'+hash).trigger("click");
    }
    //return hash;
}
function wait(ms) {
    var start = new Date().getTime();
    var end = start;
    while (end < start + ms) {
        end = new Date().getTime();
    }
}

// advanced Filter


function applySQLFilter(ini) {
    $(ini).button('loading');
    var form = $(ini).parents('form:first');
    var form_data = $(form).serializeArray();
    var sqlFilter = "";
    $.each(form_data, function (key, input) {
        var filterVal = (input.value == undefined || input.value == "NULL" || input.value == "") ? null : "'" + input.value + "'";
        if (!!input.value) {
            if (sqlFilter == "")
                sqlFilter = sqlFilter.concat(input.name, "=", filterVal).trim();
            else
                sqlFilter = sqlFilter.concat(" AND ", input.name, "=", filterVal).trim();
        }
    });
    setCookie('sqlFilter', sqlFilter, 0, 0, 10);
    $.when($.ajax(loadContent(1))).done(function () { $(ini).button('reset'); });
}

function resetSQLFilter(ini) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    $(ini).button('loading');
    var divname = ['contentWrapper'];
    var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + getCode() + '&stateid=' + getState() + '&bSearchText=' + getSearchText() + unique;
    //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];
    var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode()];
    setCookie('sqlFilter', "", 0, 0, 0);
    $.when($.ajax(loadContent(1))).done(function () {
        $(ini).button('reset');
    });
}

// popup delegator

function delegatorModal(isRevoke) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    var kukis = getCode() + '_dmc';
    if (isRevoke === true) {
        $('#btnRevoke').button('loading');
        var url = "OPHCore/api/default.aspx?code=" + getCode() + "&mode=revokeDelegation" + unique;
        var revoking = $.post(url)
            .done(function (data) {
                var msg = $(data).find('message').text();
                if (msg === "" || msg == undefined || isGuid(msg) === true) {
                    $('#btnRevoke').button('reset');
                    window.location.reload();
                } else {
                    $('#delegatorModal h3').text('Oops! Something went wrong.');
                    $('#delegatorModal .modal-body').text("We are very sorry for the inconvenience. You have to revoke your delegation manually in your profile menu. Thank you for your understanding.");
                    $('#btnRevokeLater').text("Close");
                    $('#btnRevoke').hide();
                }
            });
    } else {
        setCookie(kukis, "yes", 1);
    }
}

function sortBrowse(ini, loc, code, orderBy) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    var ordered = loc === 'child' ? $(ini).data('order') : $(ini).parent().data('order');
    if (ordered === "" || ordered == undefined) ordered = "ASC";
    else if (ordered === "ASC") ordered = "DESC";
    else ordered = "ASC";
    $(ini).data('order', ordered).attr('disabled', true).css("cursor", "progress");

    if (orderBy && orderBy !== "") var sortOrder = orderBy + " " + ordered;

    if (loc === "header") {
        setCookie('sortOrder', sortOrder, 0, 1, 0);
        loadContent(1);
    } else {
        var sqlfilter = document.getElementById("filter" + code.toLowerCase()).value;
        var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + sqlfilter + '&sortOrder=' + sortOrder + '&bPageNo=1' + unique;
        var divName = ['child' + String(code).toLowerCase() + getGUID()];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];
        var xsldoc = 'OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_childBrowse';
        pushTheme(divName, xmldoc, xsldoc, true);
    }
}
function form_init() {
    window.onbeforeunload = function (event) {
        if (form_added || form_edited) {
            var message = 'Some data not yet saved. Are you sure want to leave?';
            if (typeof event === 'undefined') {
                event = window.event;
            }
            if (event) {
                event.returnValue = message;
            }
            return message;
        }
    };
	setTimeout(function() {form_preset();}, 100);
}


function form_preset() {
	if (getGUID()==='00000000-0000-0000-0000-000000000000') {
		var query = window.location.search.substring(1);
		var code=getCode();
		var vars = query.split("&");
		for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split("=");
			
			if (document.getElementById(pair[0])) {
				if (document.getElementById(pair[0]).type === "checkbox") {
					if (pair[1] === "1") {
						document.getElementById(pair[0]).checked = true;
						document.getElementById(pair[0]).value = 1;
					} else {
						document.getElementById(pair[0]).checked = false;
						document.getElementById(pair[0]).value = 0;
					}
				} else {
					if (pair[1] !== '') {

						if (document.getElementById(pair[0]).type === 'select-one') {
							var checktext; 
							if ($(this.nextSibling)[0]!=undefined) checktext = $(this.nextSibling)[0].tagName;
							if (checktext === pair[0] + '_name') {
								var newOption = new Option($(this.nextSibling).text(), pair[1], true, true);
								$("#" + pair[0]).append(newOption).trigger('change');
							} else {
								var defer = [];
								autosuggest_editValue(defer, pair[0], code, pair[0], pair[1], false);
								
							}
						
						} else if (document.getElementById(pair[0]).type != undefined && document.getElementById(pair[0]).type != '') {
							document.getElementById(pair[0]).value = pair[1];
						} else {
							document.getElementById(pair[0]).innerHTML = pair[1];
						}

					}
					if ($(this).attr('display') === 'show') {
						if ($('[name=' + pair[0] + ']').data("type") === 'dateBox')
							$('[name=' + pair[0] + ']').parent().parent().show();
						else
							$('[name=' + pair[0] + ']').parent().show();
					}
					else if ($(this).attr('display') === 'hide') {
						if ($('[name=' + pair[0] + ']').data("type") === 'dateBox')
							$('[name=' + pair[0] + ']').parent().parent().hide();
						else
							$('[name=' + pair[0] + ']').parent().hide();
					}

					if ($(this).attr('readonly') === 'true' || $(this).attr('readonly') === '1') {
						$('[name=' + pair[0] + ']').parent().removeClass('enabled-input').addClass('disabled-input');
						$('[name=' + pair[0] + ']').parent().attr('disabled', 'disabled');
					}
					if ($(this).attr('readonly') === 'false' || $(this).attr('readonly') === '0') {
						$('[name=' + pair[0] + ']').parent().removeClass('disabled-input').addClass('enabled-input');
						$('[name=' + pair[0] + ']').parent().removeAttr('disabled');
					}

					if ($(this).attr('style')) {
						var style = $(this).attr('style');
						$('[name=' + pair[0] + ']').parent().attr('style', style);
					}
					
				}
			}		
			preview(1, code, getGUID(), "form" + code, null);	
			
		}
	}
}


function goTo(url, isPost) {
    if (isPost) {
        urlsplit = url.split('?');
        urlonly = urlsplit[0];
        parform = urlsplit[1];
        par = parform.split('&');


        $('body').append($('<form/>')
            .attr({ 'action': urlonly, 'method': 'post', 'id': 'replacer' }));
        par.forEach(function (x) {
            $('#replacer').append($('<input/>')
                .attr({ 'type': 'hidden', 'name': x.split('=')[0], 'value': x.split('=')[1] })
            );

        });
        $('#replacer').submit();
    }
    else
        window.location = url;


}


function genReport(code, outputType, otherPar, isPop) {

    otherPar = (otherPar) ? "&" + otherPar : "";
    url = 'OPHCore/api/msg_rptDialog.aspx?mode=' + outputType + '&code=' + code + otherPar+"&pop="+(isPop?1:0);

    urlsplit = url.split('?');
    urlonly = urlsplit[0];
    parform = urlsplit[1];
    par = parform.split('&');

    $('body').append($('<form/>')
        .attr({ 'action': urlonly, 'method': 'post', 'id': 'report', 'target': 'report' }));

    var thisForm = 'form';
    var dataFrm = $(thisForm).serialize();
	if (isPop) {
		dataFrm.split('&').forEach(function (i) {
			d = i.split('=');
			var newVal = d[1];
			if (newVal != undefined && parform.indexOf(d[0]) == -1) {
				newVal = newVal.replace(/</g, '&lt;');
				newVal = newVal.replace(/>/g, '&gt;');
				//dataForm.append(d[0].toString(), d[1].toString());
				$('#report').append($('<input/>')
					.attr({ 'type': 'hidden', 'name': d[0].toString(), 'value': d[1].toString() })
				);
			}
		});

		par.forEach(function (x) {
			$('#report').append($('<input/>')
				.attr({ 'type': 'hidden', 'name': x.split('=')[0], 'value': x.split('=')[1] })
			);
		});
		//$("#report").bind('ajax:complete', function() {

         // tasks to do 
			
	
		//});

		$('#report').submit();
		$('#report').remove();
	
			
	}
	else {
		$.ajax({
		 type: "POST",
		  url: url,
		  data: dataFrm,
		  success: function(data) {
			$('#btnPDF').button('reset');
			$('#btnXLS').button('reset');
			// callback code here
			var s=findScript(data);
			if (s) eval(s);
			else 
				reloadQueryResult();
				//window.location.reload();

		   }
		})
	}
	
    
}

function reloadQueryResult() {
	var divname = ['ReportResult'];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];
    var xsldoc = ['OPHContent/themes/'+loadThemeFolder()+'/xslt/_report_result.xslt'];
	var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + getCode(); 
	pushTheme(divname, xmldoc, xsldoc, true);
	
	
}

//radio
function panel_display(t, val, isdv) {
    try {
        document.getElementById('accordion_' + t).style.display = 'block';
    } catch (e) { }
    if (!isdv) {
        if ($(t).data("child") === 'Y') {
            $('#child_button_addSave').show();
            $('#child_button_save').show();
            $('#child_button_cancel').show();
            $('#child_button_delete').hide();
            $('#child_button_save2').show();
            $('#child_button_cancel2').show();
            $('#child_button_delete2').hide();
        }
        else {
            $('#button_save').show();
            $('#button_cancel').show();
            $('#button_submit').hide();
            $('#button_delete').hide();
            $('#button_approve').hide();
            $('#button_reject').hide();
            $('#button_close').hide();
            $('#button_save2').show();
            $('#button_cancel2').show();

            $('.action-save').show();
            $('.action-cancel').show();
            $('.action-submit').hide();
            $('.action-delete').hide();
            $('.action-approve').hide();
            $('.action-reject').hide();
            $('.action-close').hide();
        }
    }
}
function searchText(e, searchvalue, location) {
    if (e.keyCode == 13 || e.type == 'click') {
        searchvalue = (searchvalue == undefined || searchvalue == null) ? $('#searchBox').val() : searchvalue;
        searchvalue.split("'").join("");
        if (searchvalue.indexOf('@') >= 0 || searchvalue.indexOf('*') >= 0) {
            var url = "OPHCore/api/default.aspx?mode=codeSearch&searchValue=" + searchvalue + '&unique=' + getUnique();
            var posting = $.post(url);
            posting.done(function (data) {
                var regex = $(data).find('search').attr('regex');
                var code = $(data).find('code').text();
                var msg = $(data).find('message').text();

                if (msg == "" || msg == undefined) {
                    //valid
                    var withGUID = (regex == '*') ? '&GUID=' + zeroGUID() : '';
                    code = (code == undefined || code == "") ? getCode() : code;
                    window.location.replace('?code=' + code + withGUID);
                } else {
                    //invalid
                    showMessage(msg);
                }
            });
        }
        else {
            if (location == 20) {
                //a = a;  //show quick search
                //LoadNewPart('searchResult')
                loadSearchResult(searchvalue);
            }
            else {  //load browse
                setCookie('bSearchText', searchvalue.split('+').join('%2B'), 0, 1, 0);
                var code = getCode();
                //loadBrowse(code, searchvalue.split('+').join('%2B'));
				var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();
				
				var divname = ['contentWrapper'];
                    var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode()];
                    var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + 1 + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&sortOrder=' + getOrder() + unique;
                    pushTheme(divname, xmldoc, xsldoc, true, function() {
                        setCookie(getCode().toLowerCase()+'_curPage', 1, 1, 0, 0);
                        //scrollLoad=false;
                    });
                //loadContent(1);
            }
        }
    }
}

function searchTextChild(e, searchvalue, code, isClear) {
    var xsldoc;
    if (e.keyCode == 13 || isClear) {
        var bSearchText = searchvalue;
        var mode = getCookie(code.toLowerCase() + '_browseMode');
        var sqlfilter = document.getElementById("filter" + code.toLowerCase()).value;
        var pageNo = (pageNo == undefined) ? 1 : pageNo;

        var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + sqlfilter + '&bPageNo=' + pageNo + '&bSearchText=' + bSearchText + '&date=' + getUnique();
        var divName = ['child' + String(code).toLowerCase() + getGUID().toLowerCase()];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];
        if (mode == 'inline')
            //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childInline.xslt"];
            xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_childInline'];

        else if (mode != undefined && mode.indexOf('custom') >= 0)
            //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_" + mode + ".xslt"];
            xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + mode];
        else
            //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];
            xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_childBrowse'];

        pushTheme(divName, xmldoc, xsldoc, true);
    }
}

function checkrequired(Names, guid, output) {
    var result = 'good';
    for (i = 0; i < Names.length - 1; i++) {
        var val;
        if ($("#" + Names[i + 1] + (guid != '' ? '_' + guid : '')).prop("tagName") == 'TD') {
            val = $("#" + Names[i + 1] + (guid != '' ? '_' + guid : '')).html();
        }
        else {
            if (document.getElementById(Names[i + 1] + (guid != '' ? '_' + guid : '')) != undefined) {
                val = document.getElementById(Names[i + 1] + (guid != '' ? '_' + guid : '')).value;
                val = val.trim();
            }
        }

        if (val == '' || val == undefined || val == "NULL") {
            if (!guid)
                result = document.getElementById(Names[i + 1] + 'caption').innerHTML + ' need to be filled';
            else
                result = Names[i + 1] + ' need to be filled';
            output = (output == 'id') ? Names[i + 1] : result;
            break;
        }
    }
    return output;
}




function loadSearchResult(searchText, isDraft) {
    //function loadSeachResult(bCode, bGUID, guestID, f) { //bmode, bcode, bguid hanya dipakai kalau mau pindah lokasi saja
    //var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();
    //if (bCode != undefined) setCookie('code', bCode, 0, 1, 0);
    //if (bGUID != undefined) setCookie('GUID', bGUID, 0, 1, 0);
    //var tcode = getQueryVariable('tcode');
    //setCookie('guestID', guestID, 7, 0, 0);
	var stateId='';
	if (isDraft) stateId='0'
    var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + getCode() + '&bSearchText=' + searchText+'&stateId='+stateId;
    try {
        var divname = ['searchResult'];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];
        var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=_form_search'];

        pushTheme(divname, xmldoc, xsldoc, true, function (xml) {
            themeXML = xml;
            $('#tabSearchResult').removeClass('hidden');
            $('#tabSearchResult').addClass('active');
        });
    }
    catch (e) {
        showMessage(e.Message, 4, true);
    }
}

function loadForm(bCode, bGUID, f) {
    if (getQueryVariable("code") == bCode.toLowerCase() && (getQueryVariable("GUID") != undefined && getQueryVariable("GUID") != null)) {
        var xmldoc = 'OPHCore/api/default.aspx?mode=form&code=' + bCode + '&GUID=' + bGUID;
        try {
            var divname = ['contentWrapper'];
            //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];
            var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage() + '_' + getMode()];

            pushTheme(divname, xmldoc, xsldoc, true, function (xml) {
                themeXML = xml;
				//refreshTalk(bGUID, '', 20);				
				setCookie("GUID", bGUID, 0, 0, 1);
            });
        }
        catch (e) {
            showMessage(e.Message, 4, true);
        }

    }
    else {
        //OPH4 --refreshHeader
        //var url = "index.aspx?code=" + bCode + '&guid=' + bGUID;
        //document.location = url;
		setCookie("GUID", bGUID, 0, 0, 30)
		loadContent(1, false);
    }
}

var divname = ['frameMaster'];
        //var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];
        var xsldoc = ['OPHCore/api/loadtheme.aspx?code=' + getCode() + '&theme=' + loadThemeFolder() + '&page=' + getPage()];
