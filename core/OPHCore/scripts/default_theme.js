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

function loadChild(code, parentKey, GUID, pageNo) {
    pageNo = (pageNo == undefined) ? 1 : pageNo;

    var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + '&date=' + getUnique();

    var divName = ['child' + String(code).toLowerCase() + GUID];
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



