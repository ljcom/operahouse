function initTheme(bCode, bGUID, guestID, f) { //bmode, bcode, bguid hanya dipakai kalau mau pindah lokasi saja

    if (bCode != undefined) setCookie('code', bCode, 0, 1, 0);
    if (bGUID != undefined) setCookie('GUID', bGUID, 0, 1, 0);
    var tcode = getQueryVariable('tcode');
    setCookie('guestID', guestID, 7, 0, 0)

    try {
        var pathPage = 'index.aspx?mode=' + getMode();
        if (getCode().toLowerCase() == 'dumy' || getCode().toLowerCase() == '404') // || getCode().toLowerCase() == 'login')
            var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        else
            var xmldoc = 'OPHCore/api/default.aspx?mode=master&code=' + getCode() + '&stateid=' + getState() + '&unique=' + getUnique();

        if (tcode != undefined)
            var xmldoc = xmldoc + '&tcode=' + tcode

        var divname = ['frameMaster'];
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];

        if ((getGUID() == '' || getGUID() == undefined) && getCode().toLowerCase() != 'login') {
            $.get('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_sidebar.xslt').done(function () {
                divname.push('sidebarWrapper');
                xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_sidebar.xslt');

            }).always(function () {
                pushTheme(divname, xmldoc, xsldoc, true);
            });

        }
        else { pushTheme(divname, xmldoc, xsldoc, true); }



    }
    catch (e) {

        showMessage(e.Message, 4, true);
    }

}

function loadThemeFolder() {
    var themeName = document.getElementById('themeName')
    if (themeName != undefined) {
        return themeName.innerHTML
    } else {
        return getCookie('themeFolder')
    }
}


function getMode() {
    var mode = (getQueryVariable('mode') == undefined) ? '' : getQueryVariable('mode').toLowerCase();
    if (mode == 'export') {
        var ret = 'export'
    } else {
        if (getGUID() && getGUID != '') 
            var ret = 'form'
        else 
            var ret = 'browse'
    }
    return ret
    //return (getGUID() == '' || getGUID() == undefined) ? 'browse' : 'form'
}

function getCode() { return (getCookie('code') == undefined ? getQueryVariable("code") : getQueryVariable("code")) }

function lastCode() { return getCookie('lastCode'); }

function getGUID() { return (getCookie('GUID') == undefined || getCookie('GUID') == "" ? getQueryVariable("GUID") : getQueryVariable("GUID")) }

function getPage() {
    var pageName = document.getElementById('pageName')
    if (pageName != undefined) {
        return pageName.innerHTML
    } else {
        return getCookie('page')
    }
}


function getState() { return (getQueryVariable("stateid") == undefined ? getCookie('stateid') : getQueryVariable("stateid")) }

function getSearchText() { return (getQueryVariable("bSearchText") == undefined ? getCookie('bSearchText') : getQueryVariable("bSearchText")) }

function getFilter() {
    if (getCookie("sqlFilter") == undefined || getCookie("sqlFilter") == "") {
        if (getQueryVariable("sqlFilter") == undefined || getQueryVariable("sqlFilter") == "") {
            return ""
        } else {
            return getQueryVariable("sqlFilter")
        }
    } else {
        return getCookie("sqlFilter")
    }
    return (getQueryVariable("sqlFilter") == undefined ? (getCookie("sqlFilter") == undefined ? "" : getCookie("sqlFilter")) : getQueryVariable("sqlFilter"))
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
    if (h.length < 2) day = '0' + h;
    if (n.length < 2) day = '0' + n;
    if (s.length < 2) day = '0' + s;

    return [year, month, day, h, n, s].join('');
}

function loadContent(nbpage, f) {
    //main content
    if (lastCode() != getCode()) {
        setCookie('sqlFilter', "", 0, 0, 0);
        setCookie('lastCode', getCode(), 0, 0, 15);
    }

    if (getCode().toLowerCase() == 'dumy')
        var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else
        var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&date=' + getUnique();

    var divname = ['contentWrapper'];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];

    //sidebar
    divname.push('sidebarWrapper');
    xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '_sidebar.xslt');

    pushTheme(divname, xmldoc, xsldoc, true);
}//

function loadChild(code, parentKey, GUID, pageNo, mode) {
    pageNo = (pageNo == undefined) ? 1 : pageNo;

    var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + '&date=' + getUnique();

    var divName = ['child' + String(code).toLowerCase() + GUID];
    //if (code == 'modlinfo' || code == 'modlcolminfo' || code =='modlcolm')
    if(mode=='inline')
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childInline.xslt"];
    else
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];

    pushTheme(divName, xmldoc, xsldoc, true);

    //$('#' + code).on('show.bs.collapse', '.collapse', function () {
    //    $('#' + code).find('.collapse.in').collapse('hide');

    //});

    //showXML(divName, xmldoc, xsldocs, true, true, function () { });
}

function signIn(withCapcay) {
    //if (top.document.domain == window.location.hostname) {
    withCapcay = (withCapcay == 1) ? 1 : 0;
    var uid = getCookie('userId');
    if ($("#userid").val() != "") uid = $("#userid").val();
    if (getCode() == 'lockscreen') uid = getCookie('userId');
    var pwd = $("#pwd").val();

    var dataForm = $('form').serialize() + '&source=' + window.location.toString().replace('&', '*').replace('?', '*') //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.substring(2, dfLength);
    dataForm = dataForm.split('%3C').join('%26lt%3B');
    path = "OPHCore/api/default.aspx?mode=signin&userid=" + uid + "&pwd=" + pwd + "&withCaptcha=" + withCapcay;

    $.ajax({
        url: path,
        data: dataForm,
        type: 'POST',
        dataType: "xml",
        timeout: 80000,
        beforeSend: function () {
            //setCursorWait(this);
        },
        success: function (data) {
            var x = $(data).find("sqroot").children().each(function () {
                var msg = $(this).text();

                var landingPage = (getCookie('lastPar') == null || getCookie('lastPar') == '') ? '?' : getCookie('lastPar');

                if (msg != '') {
                    if ($(this)[0].nodeName == "userGUID") {
                        //setCookie('userId', $("#userid").val(), 7);
                        setCookie('userId', uid, 7);
                        window.location = landingPage;
                    }
                    if ($(this)[0].nodeName == "message") showMessage(msg, 4);
                }
                else {

                }
            });


        }
    });

}


function clearLoginText() {
    $("#userid").val('');
    $("#pwd").val('');
}

function loadForm(bCode, bGUID, f) {
    //OPH4 --refreshHeader
    var url = "index.aspx?code=" + bCode + '&guid=' + bGUID;
    document.location = url;
}

function loadBrowse(bCode, f) {
    //OPH4 --refreshHeader
    //evn=back harus di revisi
    var url = "index.aspx?env=back&code=" + bCode;
    document.location = url;
}

function showMessage(msg, mode, fokus, afterMessage) {
    var msgType;
    if (mode == 1) msgType = 'notice';
    else if (mode == 2) msgType = 'success';
    else if (mode == 4) msgType = 'error';
    else if (mode == 3) msgType = 'warning';
    else msgType = 'notice';

    if (msg == '' && (mode == 4 || mode == 3)) msg = 'Time out.';

    $("#notiTitle").text(msgType);
    $("#notiContent").text(msg);
    $("#notiModal").modal();

    if (fokus || afterMessage) {
        try {
            document.getElementById('notiBtn').onclick = function () {
                if (fokus) $(fokus).focus();
                if (typeof afterMessage == "function") afterMessage();
            };
        }
        catch (e) { }
    }
}

function saveFunction(code, guid, location, formId, afterSuccess) {
    var tblnm = code
    requiredname = document.getElementsByName(tblnm + "requiredname")[0];
    var result
    var idReq
    if (requiredname != undefined) {
        requiredname = requiredname.value;
        if (requiredname != '' && requiredname != undefined) {
            result = checkrequired(requiredname.split(', '), 'good');
            idReq = checkrequired(requiredname.split(', '), 'id');
        } else {
            result = 'good'
        }
    } else {
        result = 'good';
    }

    if (result == 'good') {
        //var filename = $(":file").val();
        var data = new FormData();

        if ($(':file').length > 0) {
            $.each($(':file')[0].files, function (key, value) {
                data.append(key, value);
            });
        }
        var thisForm = 'form';
        if (formId != undefined) thisForm = '#' + formId;
        if (location == 30) {
            $("#tr1_"+code+guid).children("td.cell").each(function(i) {
                f=$("#tr1_"+code+guid).children("td.cell").eq(i).data("field");
                d=$("#tr1_"+code+guid).children("td.cell").eq(i).html().replace("&nbsp;"," ");
                data.append(f, d);
            });
            cid=$("#cid").val();
            data.append("cid", cid);
        } else {
            var other_data = $(thisForm).serializeArray();
            $.each(other_data, function (key, input) {
                var newVal = input.value;
                newVal = newVal.replace(/</g, '&lt;', );
                newVal = newVal.replace(/>/g, '&gt;');
                data.append(input.name, newVal);
            });
        }
        $.ajax({
            type: "POST",
            url: "OPHCore/api/default.aspx?code=" + code + "&mode=save&cfunctionlist=" + guid + "&",
            enctype: 'multipart/form-data',
            cache: false,
            contentType: false,
            processData: false,
            data: data,
            success: function () {
                //alert("Data Uploaded: ");
            }
        }).done(function (data) {
            if (typeof afterSuccess == "function") afterSuccess(data);
        });
    }
    else {
        if (location == 50 || location == '50') { //saveModalForm
            $('#notiModal').data("message", result);
            $('#notiModal').data("colname", idReq);
            if (typeof afterSuccess == "function") afterSuccess(data);
        } else {
            if (idReq) showMessage(result, '0', idReq)
            else showMessage(result);
        }
    }
}

function wait(ms){
    var start = new Date().getTime();
    var end = start;
    while(end < start + ms) {
        end = new Date().getTime();
    }
}


function btn_function(code, GUID, action, page, location, formId, afterSuccess) {
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, browse anak:30, browse form:40

    var pg = (page == "" || isNaN(page)) ? 0 : parseInt(page);

    if (location == undefined || location == "") { location = 20 }

    if (action == "formView") {
        loadForm(code, GUID);
    } else if (action == "save") {
        //location: 0 header; 1 child; 2 browse 
        //location: browse:10, header form:20, browse anak:30, browse form:40
        saveFunction(code, GUID, location, formId, afterSuccess);
    } else {
        executeFunction(code, GUID, action, location);
    }
}


function executeFunction(code, GUID, action, location) {
    //location: browse:10, header form:20, browse anak:30, browse form:40
    var successmsg = ''
    var isAction = 1;

    if (action == 'execute') {
        successmsg = 'Approve Succesfully'
        if ((confirm("You are about to " + action + " this record. Are you sure?") == 0)) { isAction = 0; }
    } else if (action == 'force') {
        successmsg = 'Close Succesfully'
    } else if (action == 'reopen') {
        successmsg = 'Reopen Succesfully'
    } else if (action == 'inactivate') {
        successmsg = 'Inactivate Succesfully'
        if ((confirm("You are about to " + action + " this record. Are you sure?") == 0)) { isAction = 0; }
        action = "delete"
    } else if (action == 'delete') {
        successmsg = 'Delete Succesfully'
        if ((confirm("You are about to " + action + " this record. Are you sure?") == 0)) { isAction = 0; }
    } else if (action == 'restore') {
        successmsg = 'Restore Succesfully'
    } else if (action == 'wipe') {
        successmsg = 'Wipe Succesfully'
        if ((confirm("You are about to " + action + " this record. Are you sure?") == 0)) { isAction = 0; }
    }

    var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()

    if (location == undefined || location == "") { location = 20 }
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, browse anak:30, browse form:40

    if (isAction == 1) {
        $.post(path, function (data) {
            var msg = $(data).find('message').text();
            if (msg == '' || msg == 'Approval Succesfully' || msg.substring(0, 1) == '2') {
                //location: 0 header; 1 child; 2 browse 
                //location: browse:10, header form:20, browse anak:30, browse form:40
                //if ($("#tr1_" + code + GUID) && location != '10' && action == "delete") {
                if (action == "delete" && (location == 30 || location == 40)) {
                    var g=GUID.split(",");
                    g.forEach(function(i){
                        $("#tr1_" + code + i).remove();
                        $("#tr2_" + code + i).remove();
                    })
                }
                else {
                    if (action = 'delete' && location == 20) {
                        //location: 0 header; 1 child; 2 browse 
                        //location: browse:10, header form:20, browse anak:30, browse form:40

                        window.location = 'index.aspx?code=' + getQueryVariable("code");
                    }
                    else {
                        //showMessage(successmsg);
                        loadContent(1);
                        showMessage(successmsg);
                    }

                    //window.location.reload();
                }
            } else {
                showMessage(msg);
            }
        });
    }
}
