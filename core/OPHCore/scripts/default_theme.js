function initTheme(bCode, bGUID, f) { //bmode, bcode, bguid hanya dipakai kalau mau pindah lokasi saja

    if (bCode != undefined) setCookie('code', bCode, 0, 1, 0);
    if (bGUID != undefined) setCookie('GUID', bGUID, 0, 1, 0);

    //if (getCode() != bCode || getMode() != bMode
    //    || (bCode == 'view' && getGUID() != bGUID)) {
    //    document.location.href = document.location.href.replace(document.location.search, '') + '?mode=' + bMode + '&code=' + bCode;
    //}
    //else {
    try {
        var pathPage = 'index.aspx?mode=' + getMode();
        if (getCode().toLowerCase() == 'dumy' || getCode().toLowerCase() == '404') // || getCode().toLowerCase() == 'login')
            var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        else
            var xmldoc = 'OPHCore/api/default.aspx?mode=master&code=' + getCode() + '&stateid=' + getState() + '&unique=' + getUnique();

        var divname = ['frameMaster'];
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];

        //showXML('frameMaster', xmldoc, xsldoc, true, true, function () {
        //    if (typeof f == "function") f();

        //    setCursorDefault();

        //});
        pushTheme(divname, xmldoc, xsldoc, true);

    }
    catch (e) {
        //alert(e.Message);
        showMessage(e.Message, 4, true);
    }
    //}
}

function loadThemeFolder() {
    var themeName = document.getElementById('themeName')
    if (themeName != undefined) {
        return themeName.innerHTML
    } else {
        return getCookie('themeFolder')
    }
}

function getMode() { return (getGUID() == '' || getGUID() == undefined) ? 'browse' : 'form' }

function getCode() { return (getCookie('code') == undefined ? getQueryVariable("code") : getQueryVariable("code")) }

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
    //if (mode.toLowerCase() == 'm' && getMode().toLowerCase() == 'browse')
    //    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_child' + getMode() + '.xslt';
    //else
    if (getCode().toLowerCase() == 'dumy')
        var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else
        var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&date=' + getUnique();

    var divname = ['contentWrapper'];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];

    //sidebar
    divname.push('sidebarWrapper');
    xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '_sidebar.xslt');

    pushTheme(divname, xmldoc, xsldoc, true);
}

function loadChild(code, parentKey, GUID, pageNo) {
    pageNo = (pageNo == undefined) ? 1 : pageNo;

    var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + '&date=' + getUnique();

    var divName = ['child' + String(code).toLowerCase()];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];

    pushTheme(divName, xmldoc, xsldoc, true);

    //showXML(divName, xmldoc, xsldocs, true, true, function () { });
}

function signIn() {
    //if (top.document.domain == window.location.hostname) {
    var uid = document.getElementById("userid").value;
    var pwd = document.getElementById("pwd").value;

    var dataForm = $('#signinForm').serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.substring(2, dfLength);
    dataForm = dataForm.split('%3C').join('%26lt%3B');
    path = "OPHCore/api/default.aspx?mode=signin&userid=" + uid + "&pwd=" + pwd;

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
                //why env=back?
                var landingPage = (getCookie('lastPar') == null || getCookie('lastPar') == '') ? '?env=back' : getCookie('lastPar');
                //var env = getQueryVariable("env");
                //var str1 = landingPage
                //var nFront = str1.indexOf("env=front");
                //var nBack = str1.indexOf("env=back");
                //if (env.toLowerCase() == 'back' && nFront != '-1') {
                //    landingPage = 'index.aspx?env=back'
                //}else if(env.toLowerCase() == 'front' && nBack != '-1'){ 
                //    landingPage = 'index.aspx?env=front'
                //}else {
                //    landingPage = landingPage                
                //}
                if (msg != '') {
                    if ($(this)[0].nodeName == "hostGUID") window.location = landingPage;
                    if ($(this)[0].nodeName == "message") showMessage(msg, 4);
                }
                else {

                }
            });


        }
    });
    //}
    //else {
    //    alert(top.document.domain);
    //    top.document = window.location;
    //}
}


function clearLoginText() {
    $("#userid").val('');
    $("#pwd").val('');
}

//-----------------------DUMY
//function topbutton(username) {
//    if (getCookie("isLogin") == '0' || getCookie("isLogin") == undefined) {
//        document.getElementById("loginbuttons").innerHTML = '<span><a data-toggle="modal" href=".login-modal">Log in</a></span>';
//    } else {
//        document.getElementById("loginbuttons").innerHTML = '<span><a href="#">Welcome, <span style="color:#47BAC1; font-weight:bold; font-size:14px;">' + username + '</a> </span> <span><a data-toggle="modal" href="#" onClick="SignOut()"> | Log Out</a> </span>';
//    }
//}
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
//OPH3.0



function inside_master(title) {
    loadStyle('OPHContent/themes/' + loadThemeFolder() + '/styles/default.css');

    try {
        document.title = title;
    }
    catch (e) { alert(e.Message) };

    //Latu 20130604: Get formgroup from cookie
    var fname = getCookie("formname");
    if (fname == '' || fname == null || fname == 'null')
        document.getElementById("formType").innerHTML = 'FORM';
    else
        document.getElementById("formType").innerHTML = fname;

    if (getMode() == 'new') newView(getCode());
    else if (getMode() == 'view' || getMode() == 'edit') {
        showView(getCode(), getGUID());
        if (getMode() == 'edit') {
            doViewFunction('edit', 'edit the record', getGUID(), 1, '', getCode());
        }
    }
    else if (getMode() == 'report' || getMode() == 'uploader')
        showReport(getCode(), getQueryVariable("QueryCode"), getMode(), getQueryVariable("titleName"))
    else {
        var blok = 0;
        if (getCode().substring(0, 1).toLowerCase() == 't') {
            blok = 1;
        }
        refreshNextPage();
    }

    //haris
    var ndb = getQueryVariable("ndb")
    var ndb1 = ''
    var mg = getQueryVariable("mg")
    if (ndb == 0 || ndb == '' || ndb == undefined) {
        if (getCookie("showForm") == 1) {
            setCookie("showForm", "", 0, 0, 0);
            showForm(true, 'formgroup');
        }
    }
    else {
        setCookie("showForm", "", 0, 0, 0);
        showForm(false, 'formgroup');
        // setCookie("showForm", "", 0, 0, 0);
        var cc = getCookie("showForm")
    }

    if (!(getCookie("OPH_delegateUserGUID") == '' || getCookie("OPH_delegateUserGUID") == null)) {
        setCookie("OPH_delegateUserGUID", "", 0, 0, 0);
        setTimeout(function () { showMessage("You have pulled your delegation back.", 1, true); }, 1000);
    }


    document.body.onclick = function () {
        removeDropMenu();
    };

    //press esc
    document.body.onkeydown = function () {
        clearSnapbox(event);
    };

    $(window).scroll(function () {
        var oldBlock = getCookie("block");

        if (atEndofPage() && getMode() == "browse" && oldBlock == 1) {
            refreshNextPage();
        }
    });

}

function refreshNextPage(startPageOne, block) {
    $('#nextPage').css("display", "none");
    var lastPage = 0;
    if (document.getElementById("lastPageNo")) var lastPage = document.getElementById("lastPageNo").value;

    var cpage = parseInt(document.getElementById("curPage").value);
    var oldBlock = getCookie("block");
    if (!(block == 0 || block == 1)) {
        block = oldBlock ? oldBlock : 1;
        cpage += 1;
    }
    setCookie("block", block, 30, 0, 0);
    if (startPageOne) cpage = 1

    if (cpage <= lastPage || lastPage == 0) {
        var oldSearch = getCookie("search" + getCode());
        var bSearchText = document.getElementById("bSearchText").value;
        if (oldSearch && bSearchText == 'search') {
            document.getElementById("bSearchText").value = oldSearch;
            bSearchText = oldSearch;
        }
        refreshBrowse(getCode(), '', bSearchText, '', cpage, block, '', function () {
            if (document.getElementById("lastPageNo")) {
                var lastPage = document.getElementById("lastPageNo").value;
                if (lastPage == 0 || cpage == lastPage || getCode().substr(0, 1) != 't' || block == 0)
                    $('#nextPage').css("display", "none");
                else
                    $('#nextPage').css("display", "block");
            }
        });
    }
}

//function refreshBrowse(bCode, bGUID, bsearchText, bSortOrder, bpageNo, block, stateid, f) {
//    stateid = getState();
//    try {
//        //haris
//        if (block = undefined) {
//            block = 1;
//        }
//        var ndb = getQueryVariable("ndb")
//        var mg = getQueryVariable("mg")
//        var acc = getQueryVariable("acc")
//        var ndb1 = ''

//        if (ndb == 0 || ndb == '' || ndb == undefined) {
//            ndb == '';
//        }
//        else {
//            ndb1 = '&ndb=1&mg=' + mg + '&acc=' + acc + '&Ui=' + getCookie("OPH_UserId");
//            var cc = getCookie("OPH_UserId")
//        }
//        if (bGUID == '') {
//            if (document.getElementById("lastPageNo"))
//                var lastPage = document.getElementById("lastPageNo").value;
//            else
//                var lastPage = 0;
//        }
//        else {
//            lastPage = 0;
//            stateid = "";
//            bpageNo = 1;
//            bSortOrder = '';
//        }
//        if (bpageNo <= lastPage || lastPage == 0) {
//            var oldSearch = getCookie("search" + getCode());
//            bsearchText = document.getElementById("bSearchText").value;
//            if (oldSearch && bsearchText == 'search') {
//                document.getElementById("bSearchText").value = oldSearch;
//                bsearchText = oldSearch;
//            }

//            var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + bCode + ndb1 + '&GUID=' + bGUID + '&bSearchText=' + bsearchText + '&block=' + block + '&SortOrder=' + bSortOrder + '&bPageNo=' + bpageNo + '&stateid=' + stateid + '&date=' + getUnique();

//            var xsldoc, initial;
//            initial = ((bCode.substring(0, 1)).toUpperCase());
//            if (bCode.substring(0, 1).toLowerCase() == 't') {//(block == 1) {
//                if (bGUID == '')
//                    xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_block.xslt';
//                else
//                    xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_block_each.xslt';
//            }
//            else {
//                xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_list.xslt';
//            }
//            //
//            var browseLoc;

//            if (bGUID == '')
//                if (bpageNo == 1 || bCode.substring(0, 1).toLowerCase() != 't' || block != 1) {
//                    browseLoc = 'frameBrowse';
//                }
//                else {
//                    browseLoc = 'tmpBrowse' + bpageNo;
//                    document.getElementById("tmpBrowse" + bpageNo).innerHTML = '';
//                }
//            else
//                browseLoc = 'td_' + bGUID;

//            showXML(browseLoc, xmldoc, xsldoc, true, false, function () {
//                if (browseLoc == ('tmpBrowse' + bpageNo)) {
//                    var ntd = $('#tmpBrowse' + bpageNo).find('#contentBrowse').html();
//                    if (document.getElementById("frameBrowse").innerHTML.search("browsepage" + bpageNo) == -1) {
//                        ntd = "<TABLE id='browsepage" + bpageNo + "' style='width:100%'>" + ntd + "</TABLE>";
//                        document.getElementById("frameBrowse").innerHTML = document.getElementById("frameBrowse").innerHTML + ntd;

//                    }
//                }

//                if (typeof f == "function") f();
//                //recalculate(bCode, serverAddress, ThemeFolder);
//                setCursorDefault();

//            });


//        }
//    }
//    catch (e) { }
//}

//function refreshReport(bCode, QueryCode, bpageNo, mode, caption, f) {
//    try {

//        var xmldoc
//        var xsldoc
//        if (mode == 'report') {
//            xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + bCode + '&queryCode=' + QueryCode + '&titleName=' + caption + '&date=' + getUnique();
//            xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_report.xslt';
//        }
//        else if (mode == 'result') {
//            xmldoc = 'OPHCore/api/default.aspx?mode=uploader&code=' + bCode + '&queryCode=' + QueryCode + '&date=' + Date();
//            xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_uploader_result.xslt';
//        }
//        else {
//            xmldoc = 'OPHCore/api/default.aspx?mode=uploader&code=' + bCode + '&queryCode=' + QueryCode + '&date=' + Date();
//            xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_uploader.xslt';

//        }

//        showXML('frameReport', xmldoc, xsldoc, true, false, function () {

//            if (typeof f == "function") f();

//            setCursorDefault();

//        });

//    }
//    catch (e) { }
//}
//function refreshReport1(bCode, QueryCode, bpageNo, f) {
//    try {
//        if (document.getElementById("lastPageNo"))
//            var lastPage = document.getElementById("lastPageNo").value;
//        else
//            var lastPage = 0;
//        if (bpageNo <= lastPage || lastPage == 0) {

//            var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + bCode + '&queryCode=' + QueryCode + '&date=' + Date();
//            var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_report'
//            document.getElementById("tmpReport").innerHTML = '';
//            showXML('tmpReport', xmldoc, xsldoc, true, false, function () {
//                if (bpageNo == 1) {
//                    document.getElementById("frameReport").innerHTML = document.getElementById("tmpReport").innerHTML;
//                }
//                else {

//                    var ntd = $('#tmpReport').find('#contentReport').html();
//                    ntd = "<TABLE style='width:800px'>" + ntd + "</TABLE>";

//                    document.getElementById("frameReport").innerHTML = document.getElementById("frameReport").innerHTML + ntd;


//                }


//                if (typeof f == "function") f();

//                setCursorDefault();

//            });

//        }
//    }
//    catch (e) { }
//}
//function refreshSubBrowse(bCode, bFilter, bsearchText, bSortOrder, bpageNo, f) {
//    var bFilter = document.getElementById("parentKey").value + "='" + document.getElementById("cid").value + "'";

//    if (bFilter == "") {
//        var bFilter = document.getElementById("parentKey").value + "='" + document.getElementById("cid").value + "'";
//    }

//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + bCode + '&sqlfilter=' + bFilter + '&bSearchText=' + bsearchText + '&sortOrder=' + bSortOrder + '&bPageNo=' + bpageNo + '&block=' + 0 + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vchild_subbrowse.xslt';
//        showXML('subViewPage_' + bCode, xmldoc, xsldoc, true, true, function () {

//            if (typeof f == "function") f();

//            setCursorDefault();

//        });
//    }
//    catch (e) { }


//}
//function refreshAll(vCode, vGUID, editMode) {
//    setCursorWait(this);
//    if (vGUID != '') {
//        var time1 = (new Date()).getTime();
//        refreshHeader(vCode, vGUID, editMode, false, function () {
//            if (document.getElementById("cid").value.toUpperCase() != vGUID.toUpperCase())
//                initTheme('browse', vCode);
//            else {
//                refreshStatus(vCode, vGUID, editMode, false);

//                refreshApproval(vCode, vGUID, editMode, false);

//                refreshDocTalk(vCode, vGUID, editMode, false);

//                refreshChild(vCode, vGUID, editMode, false);
//            }

//        });
//    }
//    else {
//        //var time1 = (new Date()).getTime();
//        refreshHeader(vCode, vGUID, 2, false);

//        //var time2 = (new Date()).getTime() - time1;
//        refreshStatus(vCode, vGUID, editMode, false);

//        document.getElementById('frameViewChildren').innerHTML = '';
//        document.getElementById('frameViewApproval').innerHTML = '';
//        document.getElementById('frameViewDocTalk').innerHTML = '';

//    }
//    setCursorDefault();


//}

//function refreshHeader(vCode, vGUID, editMode, isAdhoc, f) {

//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vhead.xslt';
//        var xmldoc = 'OPHCore/api/default.aspx?mode=header&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        showXML('frameViewHeader', xmldoc, xsldoc, true, true, function () {
//            //run this to make the default value effect appear

//            preview(1, vCode, vGUID);

//            if (typeof f == "function") f();

//            if (isAdhoc) setCursorDefault();

//        });

//    }
//    catch (e) {

//        showMessage(e.Message, 4, true);

//    }
//}




//function refreshStatus(vCode, vGUID, isAdhoc) {

//    var editMode = 0;
//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=status&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vstatus.xslt';
//        showXML('frameViewStatus', xmldoc, xsldoc, true, true, function () {
//            if (isAdhoc) setCursorDefault();

//        });

//    } catch (e) {

//    }

//}

//function refreshApproval(vCode, vGUID, editMode, isAdhoc) {

//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=approval&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vapproval.xslt';
//        showXML('frameViewApproval', xmldoc, xsldoc, true, true, function () {
//            if (isAdhoc) setCursorDefault();
//        });

//    } catch (e) { }

//}

//function refreshDocTalk(vCode, vGUID, editMode, isAdhoc) {
//    if (vCode.substring(0, 1).toLowerCase() == 't') {


//        if (isAdhoc) setCursorWait(this);
//        try {

//            var xmldoc = 'OPHCore/api/default.aspx?mode=doctalk&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//            var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vdoctalk.xslt';
//            showXML('frameViewDocTalk', xmldoc, xsldoc, true, true, function () {
//                if (isAdhoc) setCursorDefault();

//            });

//        } catch (e) {

//        }
//    }
//}

//function refreshChild(vCode, vGUID, editMode, isAdhoc) {

//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=child&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vchild.xslt';
//        showXML('frameViewChildren', xmldoc, xsldoc, true, true, function () {
//            if (isAdhoc) setCursorDefault();

//        });

//    } catch (e) {

//    }

//}

//function refreshChildView(vCode, vGUID, editMode, isAdhoc) {

//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=childheader&code=' + vCode + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vhead.xslt';
//        if (vGUID == '') vGUID = 'new';

//        showXML('sbv_' + vCode + '_' + vGUID, xmldoc, xsldoc, true, true, function () {
//            if (isAdhoc) setCursorDefault();

//        });
//    }
//    catch (e) {

//        showMessage(e.Message, 4, true);
//    }
//}
//function refreshChildViewUpload(vCode, vGUID, editMode, isAdhoc, isUpload, QuerySQL) {

//    if (isAdhoc) setCursorWait(this);
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=childheader&code=' + vCode + '&isUpload=' + isUpload + '&GUID=' + vGUID + '&editMode=' + editMode + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vUpload.xslt';
//        if (vGUID == '') vGUID = 'new';
//        showXML('sbv_' + vCode + '_' + vGUID, xmldoc, xsldoc, true, true, function () {
//            if (isAdhoc) setCursorDefault();

//        });
//    }
//    catch (e) {
//        showMessage(e.Message, 4, true);
//    }
//}

//function refreshFilter(bCode, bsearchText, bpageNo) {
//    try {

//        var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + bCode + '&bSearchText=' + bsearchText + '&bPageNo=' + bpageNo + '&date=' + Date();
//        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_list.xslt';
//        showXML('frameBrowse', xmldoc, xsldoc, false, true, function () {
//            setCursorDefault();
//        });

//    }
//    catch (e) { }
//}
//function refreshQuery(queryCode, par) {

//}
//function showReport(vCode, vQueryCode, mode, caption) {
//    //modif by haris
//    document.getElementById("browseSection").style.display = "none";
//    document.getElementById("viewSection").style.display = "none";
//    document.getElementById("reportSection").style.display = "inline";
//    var time1 = (new Date()).getTime();
//    refreshReport(vCode, vQueryCode, 1, mode, caption);

//}
//function showView(vCode, vGUID, docNo) {
//    if (docNo) {
//        document.location.href = document.location.href.replace(document.location.search, '') + '?mode=view&docNo=' + docNo;
//    }
//    else if (getMode() != 'view') {
//        document.location.href = document.location.href.replace(document.location.search, '') + '?mode=view&code=' + vCode + '&GUID=' + vGUID;
//    }
//    else {
//        //$("#browseDiv").hide("slide", { direction: "down" }, 1000);
//        document.getElementById("browseSection").style.display = "none";
//        document.getElementById("viewSection").style.display = "inline";
//        //$("#viewDiv").show("slide", { direction: "down" }, 1000);
//        refreshAll(vCode, vGUID, 0, true);
//    }
//}
//function newView(tblName) {
//    var vCode = tblName;
//    if (!vCode) vCode = document.getElementById('curCode').value;
//    if (getMode() != 'new') {
//        document.location.href = document.location.href.replace(document.location.search, '') + '?mode=new&code=' + vCode;
//    }
//    else {
//        document.getElementById("browseSection").style.display = "none";
//        document.getElementById("viewSection").style.display = "inline";
//        document.getElementById("newFlag").value = "1";
//        refreshAll(vCode, '', 2, true);
//    }
//}
//function backToBrowse(tblName) {
//    var bCode = tblName;
//    if (!bCode) bCode = document.getElementById('curCode').value;
//    initTheme('browse', bCode);

//}

//function showSubBrowseView(tableName, GUID, isUpload, QuerySQL) {
//    if (isUpload == 1) {
//        if (!GUID) {
//            document.getElementById('tr_' + tableName + '_new').style.display = 'inline';
//            refreshChildViewUpload(tableName, GUID, 2, true, isUpload, QuerySQL);
//        }

//    } else {
//        if (GUID.length == 0) {
//            document.getElementById('tr_' + tableName + '_new').style.display = 'inline';
//            refreshChildView(tableName, '', 2, true);
//        }
//        else {
//            for (c = 0; c < document.getElementById('tb_' + tableName).rows.length; c++) {
//                if ((GUID.length != 0) && document.getElementById('tb_' + tableName).rows[c].id == 'tr_' + tableName + '_' + GUID) {
//                    //alert('xx');
//                    if (document.getElementById('tr_' + tableName + '_' + GUID).style.display == 'inline') {
//                        document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'none';
//                        document.getElementById('sbv_' + tableName + '_' + GUID).innerHTML = '';
//                    }
//                    else {
//                        document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'inline';
//                        refreshChildView(tableName, GUID, 0, true);
//                    }
//                }
//                else if (document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)
//            && document.getElementById('tb_' + tableName).rows[c].style.display == 'inline') {
//                    document.getElementById('tb_' + tableName).rows[c].style.display = 'none';
//                    var x = document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)[0];
//                    x = x.replace('tr', 'sbv');
//                    document.getElementById(x).innerHTML = '';
//                }
//            }
//        }


//    }

//}
//function DownloadSubBrowseView(tableName, GUID) {
//    for (c = 0; c < document.getElementById('tb_' + tableName).rows.length; c++) {

//        if ((GUID) && document.getElementById('tb_' + tableName).rows[c].id == 'tr_' + tableName + '_' + GUID) {
//            if (document.getElementById('tr_' + tableName + '_' + GUID).style.display == 'inline') {
//                document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'none';
//                document.getElementById('sbv_' + tableName + '_' + GUID).innerHTML = '';
//            }
//            else {
//                document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'inline';
//                refreshChildView(tableName, GUID, 0, true);
//            }
//        }
//        else if (document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)
//            && document.getElementById('tb_' + tableName).rows[c].style.display == 'inline') {
//            document.getElementById('tb_' + tableName).rows[c].style.display = 'none';
//            var x = document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)[0];
//            x = x.replace('tr', 'sbv');
//            document.getElementById(x).innerHTML = '';
//        }
//    }
//    if (!GUID) {
//        document.getElementById('tr_' + tableName + '_new').style.display = 'inline';
//        refreshChildView(tableName, '', 2, true);
//    }
//}

//function UploadSubBrowseView(tableName, GUID) {
//    for (c = 0; c < document.getElementById('tb_' + tableName).rows.length; c++) {

//        if ((GUID) && document.getElementById('tb_' + tableName).rows[c].id == 'tr_' + tableName + '_' + GUID) {
//            if (document.getElementById('tr_' + tableName + '_' + GUID).style.display == 'inline') {
//                document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'none';
//                document.getElementById('sbv_' + tableName + '_' + GUID).innerHTML = '';
//            }
//            else {
//                document.getElementById('tr_' + tableName + '_' + GUID).style.display = 'inline';
//                refreshChildView(tableName, GUID, 0, true);
//            }
//        }
//        else if (document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)
//            && document.getElementById('tb_' + tableName).rows[c].style.display == 'inline') {
//            document.getElementById('tb_' + tableName).rows[c].style.display = 'none';
//            var x = document.getElementById('tb_' + tableName).rows[c].id.match(/tr.*/)[0];
//            x = x.replace('tr', 'sbv');
//            document.getElementById(x).innerHTML = '';
//        }
//    }
//    if (!GUID) {
//        document.getElementById('tr_' + tableName + '_new').style.display = 'inline';
//        refreshChildView(tableName, '', 2, true);
//    }
//}
/*browse*/
//function doSearch(text, childTable) {
//    setCursorWait();
//    var bSearchText = text;
//    if (childTable) {
//        setCookie("search" + childTable, text, 0, 0, 5);
//        var bFilter = document.getElementById("parentKey").value + "='" + document.getElementById("cid").value + "'";
//        var bSortOrder = document.getElementsByName("csort" + childTable)[0].value //+ ', ' + document.getElementsByName("csortDesc" + tableName)[0].value;
//        refreshSubBrowse(childTable, bFilter, bSearchText, bSortOrder, 1);
//    }
//    else {
//        if (bSearchText.substr(0, 1) == '*') {
//            var code = bSearchText.substr(1, bSearchText.length - 1);
//            doViewNew(code);
//        }
//        else if (bSearchText.substr(0, 1) == '@') {
//            var code = bSearchText.substr(1, bSearchText.length - 1);
//            backToBrowse(code);
//        }
//        else if (bSearchText.substr(0, 1) == '#') {
//            var docNo = bSearchText.substr(1, bSearchText.length - 1);
//            //newView(code);
//            showView('', '', docNo);
//        }
//        else {
//            setCookie("search" + getCode(), text, 0, 0, 1);
//            refreshNextPage(1);
//        }
//    }
//}

function searchKeyPress(e, childTable) {
    //    if (typeof e == undefined && window.event) { e = window.event; }
    if (e.keyCode == 13) {
        //        document.getelementById('buttonSearchText').click();    
        //e.preventDefault();
        event.preventDefault ? event.preventDefault() : event.returnValue = false;
        var bSearchText = document.getElementById(e.srcElement.id).value;
        var cTable = childTable;
        if (cTable) { }
        else cTable = getCode();

        if (document.getElementById(e.srcElement.id).value == '') {
            var oldSearch = getCookie("search" + cTable);
            setCookie("search" + cTable, '', 0, 0, 1);
            document.getElementById(e.srcElement.id).value = 'search';
            if (oldSearch != '') doSearch('', childTable);      //childTable kosong jika bukan subbrowse
        }
        else
            doSearch(bSearchText, childTable);      //childTable kosong jika bukan subbrowse
        return false
    }
}

function doSort(nb, mode, fieldname, tableName) {
    if (!event.shiftKey || document.getElementsByName("csort" + tableName)[0].value.indexOf(fieldname) >= 0) {
        document.getElementsByName("csort" + tableName)[0].value = "";
    }
    if (mode == 1) {
        if (document.getElementsByName("csort" + tableName)[0].value != '') document.getElementsByName("csort" + tableName)[0].value = document.getElementsByName("csort" + tableName)[0].value + ', ';
        document.getElementsByName("csort" + tableName)[0].value = document.getElementsByName("csort" + tableName)[0].value + fieldname + ' asc';
    }
    if (mode == 2) {
        if (document.getElementsByName("csort" + tableName)[0].value != '') document.getElementsByName("csort" + tableName)[0].value = document.getElementsByName("csort" + tableName)[0].value + ', ';
        document.getElementsByName("csort" + tableName)[0].value = document.getElementsByName("csort" + tableName)[0].value + fieldname + ' desc';
    }
    //document.forms(0).style.cursor = 'wait';
    //document.forms(0).submit();
    var bCode = document.getElementById('curCode').value;
    if (tableName) bCode = tableName;
    var bPageNo = 1;
    var bSearchText = document.getElementById("bSearchText").value;
    var bSortOrder = document.getElementsByName("csort" + tableName)[0].value //+ ', ' + document.getElementsByName("csortDesc" + tableName)[0].value;
    if (bPageNo == "") bPageNo = "1";
    try {
        if (tableName) {
            var bFilter = document.getElementById("parentKey").value + "='" + document.getElementById("cid").value + "'";
            refreshSubBrowse(bCode, bFilter, '', bSortOrder, bPageNo);
        }
        else
            refreshBrowse(bCode, '', bSearchText, bSortOrder, bPageNo, 0, '');
    }
    catch (e) { }
}

function doFunction(functiontext, nbRec, caption, tableName, block, bGUID) {
    var c;
    var sAction = "";
    window.status = "Looking for records... "
    var tableName1 = tableName.length;
    var tableName2 = tableName.substring(0, 1).toLowerCase();
    //if (tableName1 >= 6 && tableName2 == 't' || tableName2 == 'c') {
    if (bGUID == '' || bGUID == undefined) {
        $('.hiddenCheckbox').each(function (index) {
            if (this.checked)
                sAction = sAction + this.id.split('check_').join('') + ',';
        });

        if (tableName1 >= 6) {
            nbRec = document.getElementsByName("CheckRecord" + tableName).length;
            if (nbRec > 1) {
                for (c = 1; c <= nbRec; c++) {
                    if ((c == 1 && document.getElementsByName("CheckGUID" + tableName)) || document.getElementsByName("CheckGUID" + tableName)[c - 1]) {
                        if (c == 1 && document.getElementsByName("CheckGUID" + tableName) && !document.getElementsByName("CheckGUID" + tableName)[1]) {
                            var cGUID = document.getElementsByName("CheckGUID" + tableName).value;
                            var isChecked = document.getElementsByName("CheckRecord" + tableName).checked;
                        }
                        if (document.getElementsByName("CheckGUID" + tableName)[c - 1]) {
                            var cGUID = document.getElementsByName("CheckGUID" + tableName)[c - 1].value;
                            var isChecked = document.getElementsByName("CheckRecord" + tableName)[c - 1].checked;
                        }
                        if (isChecked) {
                            if (sAction == '')
                                sAction = cGUID;
                            else
                                sAction = sAction + ',' + cGUID;
                            window.status = "Looking for records. Found " + cGUID + "...";
                        }
                    }
                }
            }
            else if (nbRec == 1) {
                if (document.getElementsByName("CheckRecord" + tableName)[0].checked) {
                    if (sAction == '')
                        sAction = document.getElementsByName("CheckGUID" + tableName)[0].value;
                    else
                        sAction = sAction + ',' + document.getElementsByName("CheckGUID" + tableName)[0].value;
                }
            }
        } else {
            if (nbRec > 1) {
                for (c = 1; c <= nbRec; c++) {
                    if ((c == 1 && document.forms(0).CheckGUID) || document.forms(0).CheckGUID[c - 1]) {
                        if (c == 1 && document.forms(0).CheckGUID && !document.forms(0).CheckGUID[1]) {
                            var cGUID = document.forms(0).CheckGUID.value;
                            var isChecked = document.forms(0).CheckRecord.checked;
                        }
                        if (document.forms(0).CheckGUID[c - 1]) {
                            var cGUID = document.forms(0).CheckGUID[c - 1].value;
                            var isChecked = document.forms(0).CheckRecord[c - 1].checked;
                        }
                        if (isChecked) {
                            if (sAction == '')
                                sAction = cGUID;
                            else
                                sAction = sAction + ',' + cGUID;
                            window.status = "Looking for records. Found " + cGUID + "...";
                        }
                    }
                }
            }
            else if (nbRec == 1) {
                if (document.forms(0).CheckRecord[0].checked) {
                    if (sAction == '')
                        sAction = document.forms(0).CheckGUID.value;
                    else
                        sAction = sAction + ',' + document.forms(0).CheckGUID.value;
                }
            }
        }
    }
    else
        sAction = bGUID;


    window.status = "";
    if (sAction == "") {
        var msg = 'Please select at least one record before continue.';
        //alert(msg);
        showMessage(msg, 3);
    }
    else
        if (confirm("Do you want to " + caption + "?") == 1) {
            //var serverAddress = document.getElementById("serverAddress").value;
            //serverAddress = '../../../';
            //document.forms(0).cfunctionlist.value = sAction;
            //document.forms(0).cfunction.value = functiontext;
            if (sAction == '') {
                document.getElementById('cfunctionlist').value = bGUID;
            } else {
                document.getElementById('cfunctionlist').value = sAction;
            }
            document.getElementById('cfunction').value = functiontext;
            if (tableName)
                var vCode = tableName;
            else
                var vCode = document.getElementById('curCode').value;

            //var path = 'OPHCore/api/default.aspx?mode=function&tableName=' + vCode;
            var path = 'OPHCore/api/default.aspx?mode=function&tableName=' + vCode;

            var dataForm = $('#aspnetForm').serialize().split('_').join('');

            $.ajax({
                url: path,
                data: dataForm,
                type: 'POST',
                dataType: "xml",
                timeout: 80000,
                beforeSend: function () {
                    setCursorWait(this);
                },
                success: function (data) {
                    var result = $(data).find("message").text();
                    if (result) {
                        //alert(result);
                        var captions = result.substring(1, 100)
                        var msgType = result.substring(0, 1);
                        if (!(msgType >= 1 && msgType <= 4)) msgType = 1
                        showMessage(captions, msgType);
                    }
                    else {
                        showMessage(caption + ' successfully', 2);
                    }
                    if (tableName1 > 6 && document.getElementById("parentKey")) {
                        var bCode = tableName;
                        var parentKey = document.getElementById("parentKey").value;
                        var parentGUID = document.getElementById("cid").value;
                        var bFilter = parentKey + "='" + parentGUID + "'";
                        refreshSubBrowse(bCode, bFilter, '', '', 1);
                        //showMessage(caption + " successfully", 2);
                        //refreshLog(parentKey, bFilter, 1);
                    }
                    else {
                        var bCode = document.getElementById('curCode').value;
                        var bPageNo = document.getElementById("curPage").value;
                        if (bPageNo == "") bPageNo = "1";
                        document.getElementById("bSearchText").value = "";
                        var stateid = '';
                        initTheme('master', vCode);
                        refreshBrowse(bCode, '', '', '', bPageNo, block, stateid);
                    }

                    setCursorDefault(this);
                },
                error: function (j, e, t) {
                    showMessage(t.message, 4);
                    setCursorDefault(this);
                }
            });
        }
}

function goPage(x, childTable) {
    var bCode = document.getElementById("curCode").value;
    var bPageNo = x;
    var bSearchText = document.getElementById("bSearchText").value;
    var bSortOrder = document.getElementsByName("csort")[0].value //+ ', ' + document.getElementsByName("csortDesc" + tableName)[0].value;
    if (bPageNo == "") bPageNo = "1";
    try {
        if (childTable) {
            var bCode = childTable;
            var parentKey = document.getElementById("parentKey").value;
            var parentGUID = document.getElementById("cid").value;
            var bSortOrder = document.getElementsByName("csort" + childTable)[0].value //+ ', ' + document.getElementsByName("csortDesc" + tableName)[0].value;
            var bFilter = parentKey + "='" + parentGUID + "'";
            refreshSubBrowse(bCode, bFilter, '', '', bPageNo);
        }
        else {
            var stateid = getState();
            refreshBrowse(bCode, '', bSearchText, bSortOrder, bPageNo, 0, stateid);
        }
    }
    catch (e) { }
}

function showAll() {
    var bCode = document.getElementById('curCode').value;
    var bPageNo = document.getElementById("curPage").value;
    if (bPageNo == "") bPageNo = "1";

    try {
        document.getElementById("bSearchText").value = "";
        refreshBrowse(bCode, '', '', '', bPageNo, block, stateid);
    }
    catch (e) { }
}

function selectAll(x, nbRec, code) {
    var c;
    var sAction = "";
    if (x)
        window.status = "Selecting all records... "
    else
        window.status = "Clearing all records... "

    var nbRec = document.getElementsByName("CheckRecord" + code).length;

    for (c = 0; c <= nbRec - 1; c++)
        try {
            document.getElementsByName("CheckRecord" + code)[c].checked = x
        }
        catch (e) { }

    window.status = ""
}
//function doFilter(GUID) {
//}

//function doViewFunction(functiontext, caption, strGUID, needConfirm, titleforextrafield, tableName, isheader, browse) {
//    //var serverAddress = document.getElementById("serverAddress").value;
//    //serverAddress = '../../../';
//    if (tableName)
//        var vCode = tableName;
//    else
//        var vCode = document.getElementById('curCode').value;
//    var confirmed = 1;
//    var requiredname, requiredtblvalue, validation, index;
//    validation = '';
//    requiredname = '';
//    requiredtblvalue = '';
//    try {
//        if (titleforextrafield) {
//            var x
//            x = prompt(titleforextrafield + ':', '');
//            document.all.rejectReason.value = x;
//            if (x == '') {
//                validation = 'You have to input ' + titleforextrafield + '...'
//                //alert('You have to input reject reason...');
//                //break;
//            }
//            else {
//                document.getElementById("extraField").value = x;
//            }
//        }

//        var tblnm = 'HRRRrequiredname'; document.getElementsByName(tblnm).value = document.getElementsByName(tblnm).value + ', PositionGUID'

//        if (//document.forms[0].first.value == 1 && 
//            functiontext == 'save') {
//            //popupReject();
//            //required field
//            //document.forms[0].cid.value
//            requiredname = document.getElementsByName(tableName + "requiredname")[0].value;
//            requiredtblvalue = document.getElementsByName(tableName + "requiredtblvalue")[0].value;

//            //search UnValid input
//            do {
//                //if (document.getElementById(requiredtblvalue.substring(0,requiredtblvalue.indexOf(','))).tagName=='INPUT') {
//                //    alert(requiredtblvalue.substring(0, requiredtblvalue.indexOf(',')));
//                //}
//                //if (document.getElementById(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).length>=1) {
//                //    alert('radio');
//                //}
//                if (requiredtblvalue.indexOf(',') <= 0) break;
//                var v = requiredname.substring(0, requiredname.indexOf(',')).split(' ').join('').split('\n').join('').split('\r').join('');
//                if (document.getElementsByName(v)[0]) {
//                    if (document.getElementsByName(v)[0].type != 'radio') {
//                        if (document.getElementsByName(v)[0].value == '') {
//                            if (validation == '')
//                                validation = 'You have to fill ' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(','));
//                            else validation += ', ' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(','));
//                        }
//                    } else { //radio
//                        var r = false;
//                        for (c = 0; c < document.getElementsByName(v).length; c++) {
//                            if (document.getElementsByName(v)[c].checked) { r = true; break; }
//                        }
//                        if (!r) {
//                            if (validation == '')
//                                validation = 'You have to fill ' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(','));
//                            else validation += ', ' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(','));
//                        }
//                    }

//                    requiredtblvalue = requiredtblvalue.substring(requiredtblvalue.indexOf(',') + 1, requiredtblvalue.length);
//                    requiredname = requiredname.substring(requiredname.indexOf(',') + 1, requiredname.length);
//                }
//            }
//            while (requiredtblvalue.indexOf(',') > 0)
//        }
//    }
//    catch (e) { showMessage(e.message, 4, true); }

//    //checkbox required
//    var nbcb = 0;
//    $("input[type='checkbox']").each(
//        function (index) {
//            el = $(this);
//            if (el.prop('indeterminate')) {
//                appear = true;
//                $(this).parents().each(
//                    function (i) {
//                        p = $(this);
//                        if (p.css('display') == 'none') appear = false;
//                    });

//                if (appear) nbcb++;
//            }
//        });
//    if (nbcb > 0) {
//        if (validation == '') { validation = 'You have to fill ' + nbcb + ' checkboxes'; }
//        else { validation += ' and ' + nbcb + ' checkboxes'; }

//    }
//    if (validation == '')
//        validation += manualvalidation();
//    else
//        validation += ',' + manualvalidation();

//    if (validation == '')//if valid then submit
//    {
//        if (needConfirm && !(functiontext == 'edit')) {
//            if (confirm("Do you want to " + caption + "?") == 1)
//                confirmed = 1;
//            else
//                confirmed = 0;
//        }

//        if (confirmed == 1) {
//            if (functiontext == 'add' && vCode.toLowerCase() == document.getElementById('curCode').value.toLowerCase()) {
//                var vCode = document.getElementById('curCode').value;
//                //var vGUID = getQueryVariable('GUID');
//                refreshAll(vCode, getQueryVariable('GUID'), 2, true);
//            }
//            else if (functiontext == 'edit' && vCode.toLowerCase() == document.getElementById('curCode').value.toLowerCase()) {
//                var vCode = document.getElementById('curCode').value;
//                //var vGUID = document.getElementById('cid').value;
//                //var vGUID = getQueryVariable('GUID');
//                refreshHeader(vCode, getQueryVariable('GUID'), 1, true);
//                //document.getElementById('frameViewChildren').innerHTML = '';
//            }
//            else if (functiontext == 'edit') {
//                preview(1, tableName, strGUID);
//                refreshChildView(tableName, strGUID, 1, true);
//                //document.getElementById('frameViewChildren').innerHTML = '';
//            }
//            else if (functiontext == 'cancel' && vCode.toLowerCase() == document.getElementById('curCode').value.toLowerCase()) {
//                var newFlag = document.getElementById("newFlag").value;
//                var vCode = document.getElementById('curCode').value;
//                var vGUID = document.getElementById("cid").value;
//                if (newFlag == '0') showView(vCode, vGUID);
//                else top.document.location = "OPHCore/back.aspx";
//                showMessage(caption + " successfully", 2);
//            }
//            else {
//                document.getElementById("cfunction").value = functiontext;
//                //if (!subBrowse) {
//                document.getElementById("cfunctionlist").value = strGUID;
//                //document.forms(0).elements("cid").value = strGUID;
//                //}
//                if (functiontext == 'save')
//                    var mode = 'save';
//                else
//                    var mode = 'function';

//                if (functiontext == 'force') {
//                    if (document.getElementById("rmessage")) {
//                        var comment = document.getElementById("rmessage").value;
//                    } else var comment = ''
//                }

//                var path = 'OPHCore/api/default.aspx?mode=' + mode + '&tableName=' + vCode + '&comment=' + comment;
//                var dataForm = $('#aspnetForm').serialize() //dataForm = dataForm.split('_').join('#95#');
//                //ModifiedBy eLs    =>  Allowing save using '<' && '_'
//                var dfLength = dataForm.length;
//                dataForm = dataForm.substring(2, dfLength);
//                dataForm = dataForm.split('%3C').join('%26lt%3B');

//                //endeLs
//                var bCode = tableName.length;
//                var vInit = (tableName.substring(0, 1)).toLowerCase();

//                $.ajax({
//                    url: path,
//                    data: dataForm,
//                    //new FormData($('form')[0])
//                    type: 'POST',
//                    dataType: "xml",

//                    cache: false,
//                    contentType: false,
//                    processData: false,

//                    //timeout: 80000,
//                    beforeSend: function () {
//                        setCursorWait(this);
//                    },
//                    success: function (data) {
//                        var result = $(data).find("message").text();
//                        //alert(result);
//                        var modes = result.substring(0, 1);
//                        var captions = result;

//                        if (modes == 1 || modes == 2 || modes == 3 || modes == 4)
//                            captions = result.substring(1, 100);

//                        if (result) //{
//                            //alert(result);
//                            showMessage(captions, modes);
//                        //}
//                        //else
//                        if (modes <= 2) {    //modes=status error: 1,2: ok, 3: warning, 4: error
//                            if (document.getElementById("newFlag").value == "1") {
//                                //if (modes < 2) { //?? kenapa mode lebih kecil dari 2 yang boleh?
//                                var vCode = document.getElementById('curCode').value;
//                                var vGUID = document.getElementById("cid").value;
//                                var newFlag = document.getElementById("newFlag").value;
//                                document.location.href = document.location.href.replace(document.location.search, '') + '?mode=view&code=' + vCode + '&GUID=' + vGUID;
//                                refreshAll(vCode, vGUID, 0, true);
//                                //showMessage(caption + " successfully", 2);
//                            }
//                            else
//                                if (tableName) {
//                                    // if (bCode > 6 && tableName != "maSIGNBRAN" && tableName != "caUGRPMODL" && tableName != "maPRODISKU") {
//                                    if (bCode > 6 && isheader != 1) {
//                                        var parentKey = document.getElementById("parentKey").value;
//                                        var vCode = document.getElementById('curCode').value;
//                                        var parentGUID = document.getElementById("cid").value;
//                                        var bFilter = parentKey + "='" + parentGUID + "'";
//                                        refreshSubBrowse(tableName, bFilter, '', '', 1);
//                                        preview(1, tableName, strGUID);                 // harus aktif untuk merefresh header
//                                        //refreshLog(parentKey, bFilter, 1);
//                                        //showMessage(caption + " successfully", 2);
//                                        //document.getElementById("statusSection").style.display = "inline";
//                                    }

//                                    else if (functiontext) {
//                                        var bCode = document.getElementById('curCode').value;
//                                        var vGUID = strGUID;

//                                        if (browse) {
//                                            refreshBrowse(bCode, '', '', '', 1, 1, stateid);

//                                        } else if (functiontext == "execute" || functiontext == "force" || functiontext == "delete" || functiontext == "wipe" || functiontext == "reopen") {
//                                            initTheme('browse', bCode);
//                                            //showView(bCode, vGUID)
//                                        } else if (functiontext) {
//                                            showView(bCode, vGUID)

//                                        }

//                                        else {
//                                            refreshHeader(bCode, vGUID, 0, true);
//                                            refreshStatus(bCode, vGUID, 0, true);
//                                            refreshDocTalk(bCode, vGUID, 0, true);
//                                            refreshApproval(bCode, vGUID, 0, true);
//                                        }
//                                        if (document.getElementById("parentKey")) {
//                                            var parentKey = document.getElementById("parentKey").value;
//                                            var parentGUID = document.getElementById("cid").value;
//                                            var bFilter = parentKey + "='" + parentGUID + "'";
//                                            //refreshLog(parentKey, bFilter, 1);
//                                        }
//                                    } else {
//                                        var vCode = document.getElementById('curCode').value;
//                                        var vGUID = document.getElementById("cid").value;
//                                        refreshHeader(vCode, vGUID, 0, true);
//                                    }
//                                }
//                                else {
//                                    var vCode = document.getElementById('curCode').value;
//                                    //var vGUID = document.getElementById("cid").value;
//                                    var vGUID = strGUID;
//                                    var newFlag = document.getElementById("newFlag").value;
//                                    //setCookie("postMessage", caption + " successfully", 0, 1, 0);
//                                    top.document.location = document.location.href.replace(document.location.search, '') + '?mode=view&code=' + vCode + '&GUID=' + vGUID;
//                                }
//                        }
//                        setCursorDefault(this);
//                    },
//                    error: function (j, e, t) {
//                        //alert(t);
//                        showMessage(t.message, 4);
//                        setCursorDefault(this);
//                    }
//                });

//                /* branch:xml
//                document.forms(0).cfunction.value = functiontext;
//                if (!subBrowse)
//                document.forms(0).cfunctionlist.value = strGUID;
//                document.forms(0).submit();
//                */
//                //document.forms(0).style.cursor = 'wait';
//                //this.style.cursor = 'wait';
//                /*
//                var options = {
//                iframe: true,
//                iframeTarget: "frmMessage",
//                beforeSubmit: function() {

//                $.blockUI({ css: { backgroundColor: '#888888', color: '#fff' }, message: '<h1>Just a moment...</h1>' });
//                },
//                success: function() {
//                //refreshSubview(vp);
//                $.unblockUI();
//                document.forms(0).style.cursor = 'default';
//                //alert('done!');
//                $().toastmessage('showSuccessToast', "Save Record is done successfully.");

//                }
//                };
//                $("#aspnetForm").ajaxSubmit(options);
//                */
//                //save header

//            }
//        }
//        else setCursorDefault(this);
//    }
//        //if not valid show message
//    else {
//        confirmed = 0;
//        validation = validation.substring(0, validation.length - 1) + validation.substring(validation.length - 1).replace(",", ".");
//        //alert(validation);
//        showMessage(validation, 3);

//        setCursorDefault(this);
//    }
//}

//var myToast;
function showMessage(msg, mode) {
    var msgType;
    if (mode == 1) msgType = 'notice';
    else if (mode == 2) msgType = 'success';
    else if (mode == 4) msgType = 'error';
    else if (mode == 3) msgType = 'warning';
    else msgType = 'notice';

    if (msg == '' && (mode == 4 || mode == 3)) msg = 'Time out.';
    //if (myToast) $().toastmessage('removeToast', myToast);

    //myToast = $().toastmessage('showToast', {
    //    stayTime: 500,
    //    text: text,
    //    sticky: sticky,
    //    position: 'top-right',
    //    type: msgType,
    //    closeText: ''
    //});
    $("#notiTitle").text(msgType);
    $("#notiContent").text(msg);
    $("#notiModal").modal();
}

/*browse*/
function selectFilter(text) {
    var n = text.indexOf("-");
    var str = text.substring(n + 2, text.length)
    str = str.replace("'", "''");
    refreshFilter(getCode(), str, 1);
}
function createUploader2(s, qcode, f, qsql, id) {
    if (qcode) {
        var url = "OPHCore/api/default.aspx?mode=upload&flag=isUpload&Separation=" + s + "&UploadFolder=" + f + "&QuerySQL=" + qsql + "&QueryCode=" + qcode + "&Id=" + id + '&date=' + Date();
        //var uploader = document.getElementById('uploader' + qcode); 
        /*upclick(
        {
        element: uploader,
        action: url,
        onstart:
        function (filename) {
        var f = document.getElementById(qcode);
        f.value = filename;
        //alert(filename);
        },
        oncomplete:
        function (r) {
        //alert(r);
        //document.getElementById(qcode).value="";
        }
        }
        );*/
        var element = '#uploader' + qcode;
        var u = $(element).upload({
            name: qcode,
            action: url,
            enctype: 'multipart/form-data',
            param: {},
            autoSubmit: true,
            onSubmit: function () { },
            onComplete: function () {
                showMessage('Upload Success', 2, 'undefined', 'undefined')
                refreshReport('CaQURY', qcode, 1, 'uploader')
            },
            onSelect: function () { }
        });
    }
}
function createUploader(t, qcode, g, fn, f) {
    if (qcode) {
        var uploader = document.getElementById('uploader' + qcode);
        var url = "OPHCore/api/default.aspx?mode=upload&code=" + t + "&GUID=" + g;

        /*        upclick(
        {
        element: uploader,
        action: url,
        onstart:
        function (filename) {
        var fx = document.getElementById(qcode);
        fx.value = filename;
        },
        oncomplete:
        function (response_data) {
        showMessage("Done", 2, true);
        }
        });
        */
        var element = '#uploader' + qcode;
        var u = $(element).upclick({
            name: qcode,
            action: url,
            enctype: 'multipart/form-data',
            param: {},
            autoSubmit: true,
            onSubmit: function () {
            },
            onComplete: function () {
                showMessage('Upload Success', 2, 'undefined', 'undefined')
                //refreshReport('CaQURY', qcode, 1, 'uploader')
                if (typeof f == "function") f();

                //AddedBy eLs ON August, 2015 
                if (qcode == t) {
                    document.location.reload();
                };
                //End--
            },
            onSelect: function (filename) {
                var fx = document.getElementById(qcode);
                fx.value = u.filename();

            }
        });
    }
}

//haris 20140318 uploaderTemplate
function showUploaderTemplate(bCode, QueryCode, bpageNo, mode, caption) {
    try {
        //var serverAddress = document.getElementById("serverAddress").value;
        //serverAddress = '../../../';
        //var ThemeFolder = document.getElementById("curTheme").value;
        var xmldoc
        var xsldoc
        if (mode == 'report') {
            xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + bCode + '&queryCode=' + QueryCode + '&titleName=' + caption + '&date=' + Date();
            xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_report.xslt';
        }
        else {
            xmldoc = 'OPHCore/api/default.aspx?mode=uploader&code=' + bCode + '&queryCode=' + QueryCode + '&date=' + Date();
            xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_uploader.xslt';
        }
        //document.getElementById("tmpReport").innerHTML = '';
        showXML('frameReport', xmldoc, xsldoc, true, false, function () {
            //document.getElementById("frameReport").innerHTML = document.getElementById("tmpReport").innerHTML;
            setCursorDefault();

        });
    }
    catch (e) { }
}

function clearSnapbox(e) {
    var keynum
    var keychar
    var numcheck

    if (window.event) // IE
    {
        keynum = e.keyCode
    }
    else if (e.which) // Netscape/Firefox/Opera
    {
        keynum = e.which
    }
    if (keynum == 27) {
        showForm(false);
    }
}
function menuBack() {
    var menu = getCookie("menuStack");
    if (!menu) menu = "";
    stack = menu.split(",");
    if (stack.length >= 2) {
        var curmenu = stack[1];
        stack.shift();
        stack.shift();
        setCookie("menuStack", stack.join(","), 30, 0, 0);

        if (curmenu == "")
            showForm(false);
        else
            showForm(null, curmenu);
    }
    else
        showForm(false);
}
function showDropMenu(x, caption, parent, mode, code) {
    //var serverAddress = document.getElementById("serverAddress").value;
    //serverAddress = '../../../';
    //var ThemeFolder = document.getElementById("curTheme").value;


    try {
        if (x || x == null) {

            var child = document.getElementById("dropMenu");
            if (child) {
                child.parentNode.removeChild(child);
            }

            var d1 = document.createElement("div");
            //d1.innerHTML = "test";
            d1.setAttribute("id", "dropMenu");
            d1.setAttribute("class", "shadow");
            d1.setAttribute("onblur", "removeDropMenu();");
            var offset = GetTopLeft(parent);
            if (mode == 0) {
                var oLeft = offset.Left;
                d1.setAttribute("style", "position:absolute; background-color:#5AD5FC; min-width:100px; width:auto; padding: 5px 5px 5px 5px; height:auto; top:55px; left:" + oLeft + "px; ");

                //d1.setAttribute("style", "position:absolute; background-color:#5AD5FC; width:auto; height:auto; top:55px; left:" + oLeft + "px; border:1px #888888 solid;");
            }
            if (mode == 2) {
                var oRight = screen.width - (offset.Left + parent.offsetWidth + getScrollBarWidth() - 10);
                //var oRight = offset.Left + parent.offsetWidth;
                d1.setAttribute("style", "position:absolute; background-color:#5AD5FC; min-width:100px; width:auto; padding: 5px 5px 5px 5px; height:auto; top:55px; right:" + oRight + "px; ");

                //d1.setAttribute("style", "position:absolute; background-color:#5AD5FC; width:auto; height:auto; top:55px; right:" + oRight + "px; border:1px #888888 solid;");
            }

            if (mode == 4) {
                var oLeft = offset.Left;
                //var oRight = offset.Left + parent.offsetWidth;
                d1.setAttribute("style", "position:absolute; background-color:white; width:auto; padding: 5px 5px 5px 5px; height:auto; top:168px; left:" + oLeft + "px; ");

                //d1.setAttribute("style", "position:absolute; background-color:#5AD5FC; width:auto; height:auto; top:55px; right:" + oRight + "px; border:1px #888888 solid;");
            }
            //d1.setAttribute("style", "position:absolute; width:100px; height:100px; top:60px; left:" + oLeft + "px; border:1px black solid; background-color:white;");            
            document.body.appendChild(d1);
            document.getElementById("dropMenu").style.display = "none";


            var xmldoc = 'OPHCore/api/default.aspx?mode=menu&code=' + code + '&caption=' + caption + '&date=' + Date() + '&formnow=' + getCookie("formactive");
            var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_menu_drop.xslt';
            showXML('dropMenu', xmldoc, xsldoc, true, true, function () {
                if (document.getElementById("dropMenu")) {
                    if (document.getElementById("dropMenu").innerHTML.length != 67) {
                        document.getElementById("dropMenu").style.display = "inline";
                    }
                    //if(caption.indexOf("form") >=0) 
                    //countnewdropmenu(getCookie("formactive"), caption, serverAddress, ThemeFolder);
                }
            });

        }
        else {
        }
    } catch (e) { }
}


function removeDropMenu() {
    var child = document.getElementById("dropMenu");
    if (child) {
        child.parentNode.removeChild(child);
    }
}

function showForm(x, caption, code) {

    //var serverAddress = document.getElementById("serverAddress").value;
    //serverAddress = '../../../';
    //var ThemeFolder = document.getElementById("curTheme").value;
    try {
        if (x || x == null) {
            document.getElementById("frameSnap").style.display = "inline";
            document.getElementById("frameForm").style.display = "inline";

            document.body.style.overflow = "hidden";
            document.getElementById("frameFormContent").innerHTML = "Loading. Please wait...";
            document.getElementById("frameFormContent").style.overflow = "auto";
            h = document.body.scrollHeight;
            document.getElementById("frameFormContent").style.height = (h - 80) + 'px';
            document.getElementById("frameFormContent").style.width = 1000 - 300;

            //Latu 20130604: Set address and parameter
            var xmldoc = 'OPHCore/api/default.aspx?mode=menu&code=' + code + '&caption=' + caption + '&date=' + Date() + '&formnow=' + getCookie("formactive");
            var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_menu.xslt';
            showXML('frameFormContent', xmldoc, xsldoc, true, true, function () {
                if (x)
                    menuStack = "";
                else
                    menuStack = getCookie("menuStack");

                if (!menuStack) menuStack = '';
                menuStack = caption + ',' + menuStack;
                setCookie("menuStack", menuStack, 30, 0, 0);
                //                if (caption.indexOf("form") >= 0) 
                //countnew(getCookie("formactive"), caption, serverAddress, ThemeFolder);
            });

        }
        else {
            document.getElementById("frameSnap").style.display = "none";
            document.getElementById("frameForm").style.display = "none";
            document.body.style.overflow = "auto";
            setCookie("menuStack", "", 30, 0, 0);
        }
    } catch (e) { }
}

function showForm1(x, caption) {
    //var serverAddress = document.getElementById("serverAddress").value;
    //serverAddress = '../../../';
    //var ThemeFolder = document.getElementById("curTheme").value;
    try {
        if (x || x == null) {
            document.getElementById("frameReject").style.display = "inline";
            document.getElementById("frameFormReject").style.display = "inline";

            //            document.body.style.overflow = "hidden";
            //            document.getElementById("Content").innerHTML = "";
            //            document.getElementById("Content").style.overflow = "auto";
            //            document.getElementById("Content").style.height = document.body.scrollHeight - 80;
            //            document.getElementById("Content").style.width = 1000 - 300;

            //Latu 20130604: Set address and parameter
            //            var xmldoc = 'OPHCore/api/default.aspx?mode=menu&code=' + caption + '&date=' + Date() + '&formnow=' + getCookie("formactive");
            //            var xsldoc = 'OPHContent/themes/' +loadThemeFolder() + '/xslt/master_menu.xslt';
            //            showXML('Content', xmldoc, xsldoc, true, true);
            //            if (x)
            //                menuStack = "";
            //            else
            //                menuStack = getCookie("menuStack");

            //            if (!menuStack) menuStack = '';
            //            menuStack = caption + ',' + menuStack;
            //            setCookie("menuStack", menuStack, 30, 0, 0);
        }
        else {
            document.getElementById("frameReject").style.display = "none";
            document.getElementById("frameFormReject").style.display = "none";
            document.body.style.overflow = "auto";
            setCookie("menuStack", "", 30, 0, 0);
        }
    } catch (e) { }
}
function menuContent(mguid, parent, t1, t2, lvel, purl, qcode, tblname, user, QueryName, nbNew) {
    //var ThemeFolder = document.getElementById("curTheme").value;
    if (t1) t1 = (t1 == undefined ? '' : t1).split('.').join(' ');
    if (t2) {
        t2 = (t2 == undefined ? '' : t2).split('.').join(' ');
    }
    else {
        tt = (t1 == undefined ? '' : t1).split(' ');
        t1 = tt[0];
        t2 = tt[1];
    }
    if (nbNew == '') nbNew = 0;
    var d0 = document.getElementById(parent)
    var d1 = document.createElement("div");
    if (t2) {
        t2 = t2;
    } else {
        var t2 = "";
    }
    var button_active = getCookie("button_s" + "_" + getCookie("OPH_AccountId") + "_" + getCookie("OPH_UserId"));
    if (button_active == null) {
        //Latu 20130725: Set NOT-SET Button Value
        setCookie("button_s" + "_" + getCookie("OPH_AccountId") + "_" + getCookie("OPH_UserId"), "BUTTON", 30, 0, 0);
    }

    var menuactive = getCookie("formactive");
    if (menuactive == null) {
        setCookie("formactive" + "_" + getCookie("OPH_AccountId") + "_" + getCookie("OPH_UserId"), "00000000-0000-0000-0000-000000000000", 30, 0, 0);
    }

    var fontColor;

    d1.setAttribute("id", "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''));
    if (button_active == ("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''))) {
        if (nbNew > 0)
            d1.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected-new.png); background-repeat:no-repeat; text-align:right;");
        else
            d1.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected.png); background-repeat:no-repeat; text-align:right;");
        fontColor = '#ffffff';
    } else {
        if (nbNew > 0)
            d1.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-new.png); background-repeat:no-repeat; text-align:right;");
        else
            d1.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame.png); background-repeat:no-repeat; text-align:right;");
        fontColor = '#7f7f7f';
    }

    // get old onmouseover attribute
    var omover = d1.getAttribute("onmouseover");

    // if onclick is not a function, it's not IE7, so use setAttribute
    if (typeof (omover) != "function") {
        //Latu 20130604: Check if actived by cookie
        if (button_active == ("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''))) {
            d1.setAttribute('onmouseover', 'color(' + "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('') + ', true, ' + nbNew + ');' + omover); // for FF,IE8,Chrome
        } else {
            d1.setAttribute('onmouseover', 'color(' + "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('') + ', false, ' + nbNew + ');' + omover); // for FF,IE8,Chrome
        }
        //d1.setAttribute('onmouseover', 'color(' + "button_" + t1 + t2 + ');' + onclick); // for FF,IE8,Chrome
        // if onclick is a function, use the IE7 method and call onclick() in the anonymous function
    } else {
        d1.onmouseover = function () {
            if (button_active == ("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''))) {
                color(d1, true, nbNew);
            } else {
                color(d1, false, nbNew);
            }
        }; // for IE7
    }

    // get old onmouseout attribute
    var omout = d1.getAttribute("onmouseout");
    // if omout is not a function, it's not IE7, so use setAttribute
    if (typeof (omout) != "function") {
        if (button_active == ("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''))) {
            d1.setAttribute('onmouseout', 'colorout(' + "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('') + ', true, ' + nbNew + ');' + omout); // for FF,IE8,Chrome
        } else {
            d1.setAttribute('onmouseout', 'colorout(' + "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('') + ', false, ' + nbNew + ');' + omout); // for FF,IE8,Chrome
        }
    } else {
        //Latu 20130520: set Attribut when mouseout
        d1.onmouseout = function () {
            if (button_active == ("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''))) {
                colorout(d1, true, nbNew);
            } else {
                colorout(d1, false, nbNew);
            }
        }; // for IE7
    }

    // get old onclick attribute
    var oclick = d1.getAttribute("onclick");
    // if onclick is not a function, it's not IE7, so use setAttribute
    if (typeof (oclick) != "function") {

        //        if (tblname == ("causr1")) {
        //            purl = purl + user;
        //
        //if (!user) user = "";
        //purl = purl.split("#user#").join(user);
        purl = purl.split("#user#").join(getCookie("OPH_UserGUID"));
        purl = purl.split("#account#").join(getCookie("OPH_AccountGUID"));

        //d1.setAttribute('onclick', 'colorclick(' + "button_" + t1 + t2 + ', "' + "button_" + t1 + t2 + '", "' + "button_s" + lvel + '");' + oclick); // for FF,IE8,Chrome
        d1.setAttribute('onmousedown', 'colorclick(' + "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('') + ', "' + lvel + '", "' + t1 + '", "' + t2 + '", "' + mguid + '", "' + purl + '", "' + qcode + '", false, ' + nbNew + ');' + oclick); // for FF,IE8,Chrome
        //setCookie("button_s", d1.getAttribute("id"), 30,0,0)
    } else {
        //Latu 20130520: set Attribut when mouseout
        d1.onclick = function () {
            //setCookie("button_s", d1.getAttribute("id"), 30,0,0)
            colorclick(d1, lvel, t1, t2, mguid, purl, qcode, false, nbNew);
        }; // for IE7
    }

    var d2 = document.createElement("div");
    if (t1.length < t2.length) {
        d2.setAttribute("style", "margin:70px 15px 0px 15px; padding:0 0 0 0; color:" + fontColor + "; font-size:arial; font-size:18pt")
        t1 = t1.substr(0, 9);
        t2 = t2.substr(0, 15);
    }
    else {
        d2.setAttribute("style", "margin:70px 15px 0px 15px; padding:0 0 0 0; color:" + fontColor + "; font-size:arial; font-size:10pt")
        t1 = t1.substr(0, 15);
        t2 = t2.substr(0, 9);
    }

    d2.innerHTML = t1;

    var d3 = document.createElement("div");
    if (t2.length <= t1.length)
        d3.setAttribute("style", "margin:0px 15px 15px 15px; color:" + fontColor + "; font-size:arial; font-size:18pt")
    else
        d3.setAttribute("style", "margin:0px 15px 15px 15px; color:" + fontColor + "; font-size:arial; font-size:10pt")

    d3.innerHTML = t2;


    d1.appendChild(d2);
    d1.appendChild(d3);
    d0.appendChild(d1);
}

function menuDropContent(mguid, parent, caption, lvel, purl, qcode, tblname, user, nbNew) {
    var cap = caption.split(" ");
    var t1 = cap[0];
    var t2 = cap[1];
    colorclick("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''), lvel, t1, t2, mguid, purl, qcode, true, nbNew); // for FF,IE8,Chrome

}
function color(cid, btn_slt, nbNew) {
    //var ThemeFolder = document.getElementById("curTheme").value;
    var obj = cid;
    if (obj) {
        if (btn_slt) {
            if (nbNew > 0)
                obj.setAttribute("style", "float:left; width:135px; height:125px; cursor:pointer; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected-glow-new.png); background-repeat:no-repeat; text-align:right;");
            else
                obj.setAttribute("style", "float:left; width:135px; height:125px; cursor:pointer; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected-glow.png); background-repeat:no-repeat; text-align:right;");
        } else {
            if (nbNew > 0)
                obj.setAttribute("style", "float:left; width:135px; height:125px; cursor:pointer; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-glow-new.png); background-repeat:no-repeat; text-align:right;");
            else
                obj.setAttribute("style", "float:left; width:135px; height:125px; cursor:pointer; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-glow.png); background-repeat:no-repeat; text-align:right;");
        }
    }
}

//Latu 20130520: set Attribut when mouseout
function colorout(cid, btn_slt, nbNew) {
    //var ThemeFolder = document.getElementById("curTheme").value;
    var obj = cid;
    if (obj) {
        if (btn_slt) {
            if (nbNew > 0)
                obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected-new.png); background-repeat:no-repeat; text-align:right;");
            else
                obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-selected.png); background-repeat:no-repeat; text-align:right;");
        } else {
            if (nbNew > 0)
                obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame-new.png); background-repeat:no-repeat; text-align:right;");
            else
                obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(OPHContent/Themes/" + loadThemeFolder() + "/images/menu-frame.png); background-repeat:no-repeat; text-align:right;");
        }
    }
}

function colorclick(cid, lvel, t1, t2, mguid, purl, code, isDrop, nbNew) {
    var serverAddress = '';
    if (document.getElementById("serverAddress")) serverAddress = document.getElementById("serverAddress").value;
    if (serverAddress == '') //serverAddress = '../../../';
        if (serverAddress.substring(serverAddress.length, serverAddress.length - 1) != '/') serverAddress += '/';

    var obj = cid;
    if (!isDrop) {
        if (nbNew > 0)
            obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(../images/menu-frame-selected.png); background-repeat:no-repeat; text-align:right;");
        else
            obj.setAttribute("style", "float:left; width:135px; height:125px; background-image:url(../images/menu-frame-selected.png); background-repeat:no-repeat; text-align:right;");

        setCookie("button_s" + "_" + getCookie("OPH_AccountId") + "_" + getCookie("OPH_UserId"), "button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join(''), 30, 0, 0);
        color(document.getElementById("button_" + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('')), true, nbNew);
    }
    purl = purl.split("#user#").join(getCookie("OPH_UserGUID"));
    purl = purl.split("#account#").join(getCookie("OPH_AccountGUID"));

    if (lvel == "0") {
        if (purl) document.location.href = purl;
        if (code) {
            if (code.indexOf("menu=") >= 0) {
                var menu = code.split("menu=").join("");
                setCookie("buttonBackMenu", menu, 30, 0, 0);
                showForm(null, menu);
            }
        }
    }
    else
        if (lvel == "5") {
            //document.location.href = document.location.href.replace(document.location.search, '') + '?mode=view&code=' + vCode + '&GUID=' + vGUID;
            //document.location.href = document.location.href.replace(document.location.search, '') + '?' + purl;
            purl = purl.split("#user#").join(getCookie("OPH_UserGUID"));
            purl = purl.split("#account#").join(getCookie("OPH_AccountGUID"));
            //if (purl) document.location.href = document.location.href.replace(document.location.search, '') + '?' + purl;
            if (purl) {
                var xmldoc = 'OPHCore/api/?' + purl + '&date=' + Date();
                //var xsldoc = 'OPHContent/themes/' +loadThemeFolder() + '/xslt/master_tableView.xslt';
                //var result = loadXMLDoc(xmldoc);
                showXML('frameTableView', xmldoc, null, true, true);

                //document.location.href = 'index.aspx?' + purl;
            }
        }
        else
            if (lvel == "10") {
                if (t1) t1 = t1.toUpperCase();
                if (t2) t2 = t2.toUpperCase(); else t2 = '';
                document.getElementById("formType").innerHTML = t1 + ' ' + t2;
                setCookie("formactive", mguid, 30, 0, 0);
                setCookie("formname", (t1 == undefined ? '' : t1).split('&').join('') + ' ' + (t2 == undefined ? '' : t2).split('&').join(''), 30, 0, 0);
                //document.location.href = document.location.href.replace(document.location.search, '') + '?mode=browse&code=taCALL&option=4&fact=' + t1 + t2;
                document.location.href = document.location.href.replace(document.location.search, '') + '?' + purl + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('');
            }
            else
                if (lvel == "20" || lvel == "30") {
                    //document.location.href = document.location.href.replace(document.location.search, '') + '?mode=view&code=' + vCode + '&GUID=' + vGUID;
                    document.location.href = document.location.href.replace(document.location.search, '') + '?' + purl;
                }
                else
                    //if (lvel == "40" || lvel == "35") {
                    if (lvel >= "35") {
                        // document.location.href = document.location.href.replace(document.location.search, '') + '?mode=report&code=caQURY&QueryCode=' + code;
                        document.location.href = document.location.href.replace(document.location.search, '') + '?' + purl + '&titleName=' + (t1 == undefined ? '' : t1).split('&').join('') + (t2 == undefined ? '' : t2).split('&').join('');

                    }
}

//Latu 20130613: Set to View Filter
function doFilter(state, stateid) {
    var bCode = document.getElementById('curCode').value;
    var mainTable = bCode.substr(2, bCode.length - 2);
    switch (state) {
        case '100':
        case "pending":
            bCode = 'ta' + mainTable;

            break;
        case '400':
        case "release":
            bCode = 'te' + mainTable;
            break;
        case '500':
        case "closed":
            bCode = 'tc' + mainTable;
            break;
        case '0':
        case "active":
            bCode = bCode.substr(0, 1) + 'a' + mainTable;
            break;
        case "deleted":
            bCode = bCode.substr(0, 1) + 'd' + mainTable;
            break;
        case "999":
            bCode = bCode.substr(0, 1) + 'd' + mainTable;
            break;
        default:
            bCode = bCode.substr(0, 1) + 'a' + mainTable;
            break;
    }
    var bPageNo = document.getElementById("curPage").value;
    if (bPageNo == "") bPageNo = "1";

    var bSearchText = document.getElementById("bSearchText").value;
    if (stateid == undefined) stateid = '';
    document.location.href = document.location.href.replace(document.location.search, '') + '?mode=browse&code=' + bCode + '&option=4&state=' + state + '&stateid=' + stateid;
}

function doViewNew(tblName) {
    var bCode = tblName;
    if (bCode == undefined || bCode == '') bCode = document.getElementById('curCode').value;
    if (bCode.substr(1, 1) != 'a') {
        var bCode = bCode.replace(bCode.substr(1, 1), "a");
    }
    document.location.href = document.location.href.replace(document.location.search, '') + '?mode=new&code=' + bCode + '&';
}
//syawal 2013-07-01  
function submitTalk(guid, e, type) {
    if (e.keyCode == 13) {
        //var cguid = document.forms[0].cid.value;
        var comment = e.srcElement.value;
        var divname = 'talk' + guid;
        if (guid == '') guid = document.forms[0].cid.value;
        if (e.srcElement.value) {
            //alert(guid);
            //var ThemeFolder = '', serverAddress = '';
            //if (document.getElementById("serverAddress")) serverAddress = document.getElementById("serverAddress").value;
            //if (serverAddress == '') //serverAddress = '../../../';
            //if (serverAddress.substring(serverAddress.length, serverAddress.length - 1) != '/') serverAddress += '/';
            //if (ThemeFolder == '') ThemeFolder = document.getElementById("curTheme").value;

            var xmldoc = 'OPHCore/api/default.aspx?mode=talk&guid=' + guid + "&comment=" + comment + "&code=CaTALK";
            var xsldoc
            if (type == undefined || type == 'browse') {
                xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_block_talk.xslt';
            }
            else {
                xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_view_vdoctalk.xslt';
                divname = 'frameViewDocTalk'
            }

            //alert(comment);
            //result = loadXMLDoc(path);

            showXML(divname, xmldoc, xsldoc, true, true)

            //e.srcElement.focus();
        }
        else {
            showMessage('Please put your comment before press enter');

        }
    }

}

function setAsWelcomePages(curPage) {
    curPage = curPage.replace('&', '*').replace('&', '*').replace('&', '*').replace('&', '*');
    var plus = 'page=1'
    //var ThemeFolder = '', serverAddress = '';
    //if (document.getElementById("serverAddress")) serverAddress = document.getElementById("serverAddress").value;
    //if (serverAddress == '') serverAddress = '../../../';
    //if (serverAddress.substring(serverAddress.length, serverAddress.length - 1) != '/') serverAddress += '/';
    //if (ThemeFolder == '') ThemeFolder = document.getElementById("curTheme").value;
    var xmldoc = 'OPHCore/api/xml_tableview.aspx?mode=page&curpage=' + curPage;
    var xsldoc = xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_thisPage.xslt';
    showXML('framesetAsWelcomePage', xmldoc, xsldoc, true, true, function () {
        showMessage('This page has been set as your welcome page', 2);

    })
}

function applyFilter(caption, key) {

    if (document.getElementById(key + "_filt")) {
        document.getElementById("filters").innerHTML = ''
    }

    var dx = document.createElement("div");
    dx.setAttribute("id", key + "_div");
    dx.setAttribute("class", "textBoxBorder");
    dx.setAttribute("style", "width:200px; height:30px;border:2px solid #F79646; background-color:white; color:black; margin:0 0 0 0; padding:0 0 0 0;");
    dx.setAttribute("name", key + "_div");

    var d0 = document.createElement("div");

    var d1 = document.createElement("label");

    d1.setAttribute("id", caption + "_filter_caption");
    d1.setAttribute("class", "labelStandard");
    d1.innerHTML = caption;
    document.getElementById("filters").appendChild(d1);
    document.getElementById(caption + "_filter_caption").appendChild(d0);


    var d2 = document.createElement("input");

    d2.setAttribute("id", key + "_filt");
    d2.setAttribute("name", key + "_filt");
    d2.setAttribute("type", "text");
    d2.setAttribute("style", "width:177px;height:30px;padding:0px 3px 3px 3px;");
    d2.setAttribute("class", "textBoxHiddenBorder");
    document.getElementById("filters").appendChild(d2);
    document.getElementById("filters").appendChild(dx);

    var d3 = document.createElement("img");
    //var ThemeFolder = ''

    //ThemeFolder = document.getElementById("curTheme").value;
    d3.setAttribute('id', key + "_name_button");
    d3.setAttribute('name', key + "_name_button");
    d3.setAttribute('class', 'comboImg');
    d3.setAttribute('style', 'vertical-align:middle');
    d3.setAttribute('src', "OPHContent/themes/" + loadThemeFolder() + "/images/select.gif");
    d3.setAttribute('title', "you can type the keyword to show the selected list or <blank> to show all list.");
    document.getElementById(key + "_div").appendChild(d3);

}
function kali() {
    try {
        document.getElementById("FASAmount").value = document.getElementById("FASQty").value * document.getElementById("UnitPrice").value;
    }
    catch (e) { }
    try {
        document.getElementById("BudgetAmount").value = document.getElementById("TotalAssetAmount").value * (document.getElementById("BudgetRatio").value / 100);
    }
    catch (e) { }
}

function PrintRptBrowse(QueryCode, parameter, outputtype) {
    mode = (outputtype == 1) ? 'dplx' : 'gbox';
    window.open('OPHCore/api/msg_rptDialog.aspx?' + mode + '=1&QueryCode=' + QueryCode + '&parameter=' + parameter + '&outputType=' + outputtype);

    //    if (outputtype == 1)
    //    else
    //        if (outputtype == 2)
    //            window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&parameter=' + parameter + '&isPrintOnly=0&outputType=' + outputtype + '&QueryCode=' + QueryCode + '&QuerySQL=' + QuerySQL + '&reportName=' + reportName + '&titleName=' + titleName + ' ' + Date() + '&subtitleName=' + subtitleName + '&ModuleGroup=' + ModuleGroup);
    //        else
    //            if (outputtype == 4) {
    //                window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&parameter=guid:' + parameter + '&isPrintOnly=0&outputType=' + outputtype + '&QueryCode=' + QueryCode + '&QuerySQL=' + QuerySQL + '&reportName=' + reportName + '&titleName=&subtitleName=' + '&ModuleGroup=' + ModuleGroup);
    //            } else
    //                window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&parameter=' + parameter + '&isPrintOnly=0&outputType=' + outputtype + '&QueryCode=' + QueryCode + '&QuerySQL=' + QuerySQL + '&reportName=' + reportName + '&titleName=&subtitleName=' + '&ModuleGroup=' + ModuleGroup);


}

function recalculate(bCode, serverAddress, ThemeFolder) {

    var delay = 1000; //1 second

    setTimeout(function () {
        var xmldoc = 'OPHCore/api/xml_tableview.aspx?mode=calculate&code=' + bCode + '&date=' + Date();
        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/Browse_Calculate.xslt';
        showXML('recalculateDiv', xmldoc, xsldoc, true, true);
    }, delay);


}


function countnew(fn, caption, serverAddress, ThemeFolder) {

    var delay = 1000; //1 second

    setTimeout(function () {

        var xmldoc = 'OPHCore/api/xml_tableview.aspx?mode=countnew&caption=' + caption + '&date=' + Date() + '&formnow=' + fn
        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/countnew.xslt';
        showXML('countnew', xmldoc, xsldoc, true, true);
    }, delay);
}

function countnewdropmenu(fn, caption, serverAddress, ThemeFolder) {

    var delay = 2000; //1 second

    setTimeout(function () {
        var xmldoc = 'OPHCore/api/xml_tableview.aspx?mode=countnew&caption=' + caption + '&date=' + Date() + '&formnow=' + fn
        var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/countnewdropmenu.xslt';
        showXML('countnew', xmldoc, xsldoc, true, true);
    }, delay);

}


function sendDocTalk() {
    if (document.getElementById("talkWait")) {
        if (document.getElementById("msgTalk")) {
            if (document.getElementById("msgTalk").value) {
                var cguid = document.forms[0].cid.value;
                document.getElementById("talkWait").style.display = "block";
                window.frames['frmDocTalk'].location = "OPHCore/api/msg_docTalk.aspx?mode=1&newMsg=" + document.forms[0].msgTalk.value + "&GUID=" + cguid
            }
            else {
                showMessage('Please put your comment before press send button');
                var m = document.forms[0].msgTalk;
                m.focus();
            }
        }
    }
}
function delDocTalk(docTalkGUID) {
    if (document.getElementById("talkWait")) {
        var cguid = document.forms[0].cid.value;
        document.getElementById("talkWait").style.display = "block";
        window.frames['frmDocTalk'].location = "OPHCore/api/msg_docTalk.aspx?mode=2&docTalkGUID=" + docTalkGUID + "&GUID=" + cguid
    }
}

function refreshSubview(vp) {
    try {
        window.frames['frmMessage' + vp].location = window.location.href + "&mode=2&vpageno=" + vp
    }
    catch (e) { }
}


function viewrowpage(a, type) {
    var allfield = eval("document.all.viewrowtypefield" + type + ".value");
    var b, c;
    do {
        b = allfield.substring(0, allfield.indexOf(","));
        // b = b.fulltrim();
        b = b.replace(/\s/g, "");
        if (b != '' && b != a) {
            eval('document.all.radio_' + b + '.style.display="none"');
        }
        else {
            eval('document.all.radio_' + b + '.style.display="inline"');
        }
        allfield = allfield.substring(allfield.indexOf(",") + 1, allfield.length);
    }
    while (allfield.indexOf(",") > 0)
}

function jumpViewPage(destPage) {
    document.forms(0).vpage.value = destPage;
    //document.forms(0).style.cursor = 'wait';
    document.forms(0).submit();
}

function jumpViewPagefilter(destPage, name, value) {
    eval("document.forms(0)." + name + ".value=value");
    document.forms(0).vpage.value = destPage;
    //document.forms(0).style.cursor = 'wait';
    document.forms(0).submit();
}

function manualvalidation() {
    return '';
}


function doSubViewFunction(functiontext, caption, strGUID, needConfirm, subBrowse) {
    var confirmed = 1;
    var requiredname, requiredtblvalue, validation, index;
    validation = '';

    if (document.forms(0).first.value == 1 && functiontext == 'save') {
        //required field
        requiredname = document.forms(0).requiredname.value;
        requiredtblvalue = document.forms(0).requiredtblvalue.value;

        //search UnValid input
        do {
            if (requiredtblvalue.indexOf(',') <= 0) break;
            if (document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).type != 'radio') {
                if (document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).value == '') {
                    if (validation == '')
                        validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                    else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                }
            } else { //radio
                var radioobj = eval('document.forms(0).' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(',')));
                var c = false;
                for (i = 0; i <= radioobj.length - 1; i++) {
                    if (radioobj(i).checked) { c = true; break; }
                }
                if (!c) {
                    if (validation == '')
                        validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                    else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                }
            }

            requiredtblvalue = requiredtblvalue.substring(requiredtblvalue.indexOf(',') + 1, requiredtblvalue.length);
            requiredname = requiredname.substring(requiredname.indexOf(',') + 1, requiredname.length);
        }
        while (requiredtblvalue.indexOf(',') > 0)
    }

    if (validation == '') validation += manualvalidation();
    else validation += ',' + manualvalidation();
    if (validation == '') {
        //if valid then submit
        if (needConfirm && caption == 'Save Records') {
            if (confirm("Do you want to " + caption + "?") == 1)
                confirmed = 1;
            else
                confirmed = 0;
        }
        if (confirmed == 1) {
            document.forms(0).cfunction.value = functiontext;
            if (!subBrowse)
                document.forms(0).cfunctionlist.value = strGUID;
            //document.forms(0).style.cursor = 'wait';
            document.forms(0).submit();
        }
    }
    //if not valid show message
    else {
        confirmed = 0;
        showMessage(validation);
    }
}


function doFunction(functiontext, nbRec, caption) {
    var c;
    var sAction = "";
    if (nbRec > 0) {
        window.status = "Looking for records... "
        for (c = 1; c <= nbRec; c++) {
            if (document.forms(0).CheckRecord[c - 1].checked) {
                if (sAction == '')
                    sAction = document.forms(0).CheckGUID[c - 1].value;
                else
                    sAction = sAction + ',' + document.forms(0).CheckGUID[c - 1].value;

                window.status = "Looking for records. Found " + document.forms(0).CheckGUID[c - 1].value + "...";
            }
        }
        window.status = "";
    }
    if (functiontext == 'add' || functiontext == 'edit' || functiontext == 'cancel') {
        document.forms(0).cfunction.value = functiontext;
        //document.forms(0).style.cursor = 'wait';
        document.forms(0).submit();
    }
    else {
        if (sAction == "")
            showMessage("Process cannot be continue before checking the box");
        else
            if (confirm("Do you want to " + caption + "?") == 1) {
                document.forms(0).cfunction.value = functiontext;
                document.forms(0).cfunctionlist.value = sAction;
                //document.forms(0).style.cursor = 'wait';
                document.forms(0).submit();
            }
    }
}

//function doFunctionPage(vp, functiontext, nbRec, caption) {
//    var c;
//    var sAction = "";
//    if (nbRec > 0) {
//        window.status = "Looking for records... "
//        for (c = 1; c <= nbRec; c++) {
//            if (((vp == 2) && (document.forms(0).CheckRecord2[c - 1].checked)) ||
//		        ((vp == 3) && (document.forms(0).CheckRecord3[c - 1].checked)) ||
//		        ((vp == 4) && (document.forms(0).CheckRecord4[c - 1].checked)) ||
//		        ((vp == 5) && (document.forms(0).CheckRecord5[c - 1].checked))) {
//                if (sAction == '') {
//                    if (vp == 2)
//                        sAction = document.forms(0).CheckGUID2[c - 1].value;
//                    else if (vp == 3)
//                        sAction = document.forms(0).CheckGUID3[c - 1].value;
//                    else if (vp == 4)
//                        sAction = document.forms(0).CheckGUID4[c - 1].value;
//                    else if (vp == 5)
//                        sAction = document.forms(0).CheckGUID5[c - 1].value;
//                }
//                else {
//                    if (vp == 2)
//                        sAction = sAction + ',' + document.forms(0).CheckGUID2[c - 1].value;
//                    else if (vp == 3)
//                        sAction = sAction + ',' + document.forms(0).CheckGUID3[c - 1].value;
//                    else if (vp == 4)
//                        sAction = sAction + ',' + document.forms(0).CheckGUID4[c - 1].value;
//                    else if (vp == 5)
//                        sAction = sAction + ',' + document.forms(0).CheckGUID5[c - 1].value;
//                }
//                if (vp == 2)
//                    window.status = "Looking for records. Found " + document.forms(0).CheckGUID2[c - 1].value + "...";
//                else if (vp == 3)
//                    window.status = "Looking for records. Found " + document.forms(0).CheckGUID3[c - 1].value + "...";
//                else if (vp == 4)
//                    window.status = "Looking for records. Found " + document.forms(0).CheckGUID4[c - 1].value + "...";
//                else if (vp == 5)
//                    window.status = "Looking for records. Found " + document.forms(0).CheckGUID5[c - 1].value + "...";
//            }
//        }
//        window.status = "";
//    }
//    if (functiontext == 'add' || functiontext == 'edit' || functiontext == 'cancel') {
//        document.forms(0).cfunction.value = functiontext;
//        document.forms(0).submit();
//    }
//    else {
//        if (sAction == "")
//            alert("Process cannot be continue before checking the box");
//        else
//            if (confirm("Do you want to " + caption + "?") == 1) {
//                document.forms(0).cfunction.value = functiontext;
//                document.forms(0).cfunctionlist.value = sAction;

//                //run function

//                document.forms(0).submit();

//            }
//        setCursorDefault(this);
//    }
//}

function selectRow(GUID, mode) {
    if (mode == 0 || mode == 1) {
        document.getElementById('check_' + GUID).checked = mode ? 1 : 0;
    }
    else {
        document.getElementById('check_' + GUID).checked = !(document.getElementById('check_' + GUID).checked);
    }
    refreshRow(GUID);
}
function refreshRow(GUID) {
    try {
        $('#tr_' + GUID).css('background', (document.getElementById('check_' + GUID).checked) ? '#DDDDDD' : '');
    } catch (e) { }
}
function highlightRow(GUID) {
    try {
        $('#tr_' + GUID).css('background', (document.getElementById('check_' + GUID).checked) ? '#CCCCCC' : 'EEEEEE');
    } catch (e) { }
}

function selectAllRows(mode) {
    //mode= 1: select all; 0: unselect all
    $('.hiddenCheckbox').each(function (index) {
        selectRow(this.id.split('check_').join(''), mode);
    });

}

//function selectAll(vp, x, nbRec) {
//    var c;
//    var sAction = "";
//    if (x)
//        window.status = "Selecting all records... "
//    else
//        window.status = "Clearing all records... "

//    for (c = 1; c <= nbRec; c++) {
//        if (vp == 2) {
//            if (document.forms(0).CheckRecord2[c - 1].checked == true)
//                document.forms(0).CheckRecord2[c - 1].checked = false;
//            else
//                document.forms(0).CheckRecord2[c - 1].checked = true;
//        }
//        else if (vp == 3) {
//            if (document.forms(0).CheckRecord3[c - 1].checked == true)
//                document.forms(0).CheckRecord3[c - 1].checked = false;
//            else
//                document.forms(0).CheckRecord3[c - 1].checked = true;
//        }
//        else if (vp == 4) {
//            if (document.forms(0).CheckRecord4[c - 1].checked == true)
//                document.forms(0).CheckRecord4[c - 1].checked = false;
//            else
//                document.forms(0).CheckRecord4[c - 1].checked = true;
//        }
//        else if (vp == 5) {
//            if (document.forms(0).CheckRecord5[c - 1].checked == true)
//                document.forms(0).CheckRecord5[c - 1].checked = false;
//            else
//                document.forms(0).CheckRecord5[c - 1].checked = true;
//        }

//    }
//    window.status = ""
//}


function showExt(x, nbRec) {
    var c;
    if (nbRec > 1) {
        for (c = 0; c <= nbRec - 1; c++)
            extPage[c].style.display = "none";
        extPage[x].style.display = "inline";
    }
}

function clearCombo(keystr, idstr, namestr) {
    var keyEl, idEl, nameEl
    keyEl = document.forms(0).item(keystr);
    idEl = document.forms(0).item(idstr);
    nameEl = document.forms(0).item(namestr);
    keyEl.value = '';
    idEl.value = '';
    nameEl.value = '';
    idEl.readOnly = false;
    idEl.className = "textBoxStandard";
    idEl.focus();
}

function SaveOtherField(x, sRtn) {
}

function doCombo(aspfile1, elKeyStr, elIDStr, elNameStr, ComboWhereField1, ComboWhereRequired1, ComboWhereField2, ComboWhereRequired2) {
    if (showModalDialog) {
        var sRtn = new Array(10);
        sRtn[0] = "0"; 		//flag
        sRtn[1] = " "; 		//elTarget	//searchtext
        sRtn[2] = " "; 		//elName	//pageno
        sRtn[3] = ""; 		//Add-3		//csort
        sRtn[4] = ""; 		//Add-4		//csortasc
        sRtn[5] = ""; 		//Add-5		//csortdesc
        sRtn[6] = " "; 		//Add-6
        sRtn[7] = " "; 		//Add-7
        sRtn[8] = " "; 		//Add-8
        sRtn[9] = " "; 		//Add-9
        sRtn[10] = " "; 		//Add-10
        sRtn[11] = " "; 		//Add-11
        sRtn[12] = " "; 		//Add-12

        var par;
        var stillloop;
        var elKey = document.forms(0).item(elKeyStr);
        var elID = document.forms(0).item(elIDStr);
        var elName = document.forms(0).item(elNameStr);
        var sqlFilter = '';
        var whereKey = '';

        if (ComboWhereField1 != '' || ComboWhereRequired1 == '1') {
            whereKey = eval('document.all.' + ComboWhereField1 + '.value');
            if (whereKey != '' || ComboWhereRequired1 == '1') {
                if (whereKey == '') {
                    whereKey = ' is null'
                }
                else {
                    whereKey = " = ''" + whereKey + "''"
                }
                sqlFilter = "&sqlFilter=" + ComboWhereField1 + "" + whereKey;
            }
        }
        if (ComboWhereField2 != '' || ComboWhereRequired2 == '1') {
            whereKey = eval('document.all.' + ComboWhereField2 + '.value');
            if ((whereKey != '' && sqlFilter != '') || ComboWhereRequired2 == '1') {
                if (whereKey == '') {
                    whereKey = ' is null'
                }
                else {
                    whereKey = " = ''" + whereKey + "''"
                }
                sqlFilter = sqlFilter + " and " + ComboWhereField2 + "" + whereKey;
            }
            else if ((whereKey != '' && sqlFilter == '') || ComboWhereRequired2 == '1') {
                if (whereKey == '') {
                    whereKey = ' is null'
                }
                else {
                    whereKey = " = ''" + whereKey + "''"
                }
                sqlFilter = sqlFilter + "&sqlFilter=" + ComboWhereField2 + "" + whereKey;
            }
        }
        if (elID.readOnly == false) {
            par = "bSearchText=" + elID.value;
        }
        //alert(sqlFilter);
        //alert(document.all.FamilyGUID.value);
        //alert(document.all.PriceGUID.value);

        do {
            stillloop = 0;
            sRtn = showModalDialog(aspfile1 + "?" + par + sqlFilter, "", "center=yes;status=no;help=no;dialogWidth=500pt;dialogHeight=360pt");

            if (sRtn != null) {
                if (sRtn[0] == "1") {
                    stillloop = 1;
                    if (sRtn[1] != " " || sRtn[1] != "") {
                        par = "bSearchText=" + sRtn[1] + "&";
                    }

                    if (sRtn[2] > 0) {
                        par = par + "bpage=" + sRtn[2] + "&";
                    }

                    if (sRtn[3] != " " || sRtn[3] != "") {
                        par = par + "csort=" + sRtn[3] + "&";
                    }

                    if (sRtn[4] != " " || sRtn[4] != "") {
                        par = par + "csortAsc=" + sRtn[4] + "&";
                    }

                    if (sRtn[5] != " " || sRtn[5] != "") {
                        par = par + "csortDesc=" + sRtn[5] + "&";
                    }
                }
            }
        }
        while (stillloop == 1)

        if (sRtn != null) {
            if (sRtn[0] == "2") {
                elKey.value = sRtn[1];
                elID.value = sRtn[2];
                elName.value = sRtn[3];
                elID.readOnly = true;
                elID.className = 'textBoxReadOnly';
                SaveOtherField(elName.name, sRtn);
                //alert(elKeyStr);	//, elIDStr, elNameStr)
            }
        }
    }
    else
        alert("Internet Explorer 4.0 or later is required.")
}

function doDialog(aspfile1, parameter, reportName) {
    if (showModalDialog) {
        var sRtn = new Array(10);
        sRtn[0] = "0"; 		//flag
        sRtn[1] = " "; 		//elTarget	//searchtext
        sRtn[2] = " "; 		//elName	//pageno
        sRtn[3] = ""; 		//Add-3		//csort
        sRtn[4] = ""; 		//Add-4		//csortasc
        sRtn[5] = ""; 		//Add-5		//csortdesc
        sRtn[6] = " "; 		//Add-6
        sRtn[7] = " "; 		//Add-7
        sRtn[8] = " "; 		//Add-8
        sRtn[9] = " "; 		//Add-9
        sRtn[10] = " "; 		//Add-10
        sRtn[11] = " "; 		//Add-11
        sRtn[12] = " "; 		//Add-12
        sRtn = showModalDialog(aspfile1, "", "center=yes;status=no;help=no;dialogWidth=300pt;dialogHeight=200pt");
        if (sRtn != undefined) {
            if (sRtn[0] == 1)
                window.frames['frmMessage'].location = 'OPHCore/api/msg_rptDialog.aspx?parameter=' + parameter + '&outputType=' + sRtn[2] + '&printerGUID=' + sRtn[1] + '&reportName=' + reportName + '&isPrintOnly=' + sRtn[3];
        }
    }
    else
        showMessage("Internet Explorer 4.0 or later is required.")
}

function changerowReadOnlyFont(substring, rowno, Bold) {
    var index, Length, ID, strguid;
    //Loop while Textbox still found
    do {
        Length = substring.length;
        index = substring.indexOf('textBoxStandard');

        if (index < 0) break;
        substring = substring.substring(index + 15, Length);
        Length = substring.length;
        index = substring.indexOf('name=');
        //Find name of Textbox
        substring = substring.substring(index + 5, Length);
        ID = substring.substring(0, substring.indexOf('>'));
        if (ID.indexOf(' ') > 0) {
            ID = ID.substring(0, ID.indexOf(' '));
        }

        //Change RowReadOnly value with RowEdit value
        if (Bold) {
            eval('window.document.all.ReadOnly' + ID + '.innerHTML="<b>"+document.all.ReadOnly' + ID + '.innerText+"</b>"');
            window.document.all.CheckRecord[rowno].checked = true;
        }
        else {
            eval('window.document.all.ReadOnly' + ID + '.innerHTML=document.all.' + ID + '.value');
            window.document.all.CheckRecord[rowno].checked = false;
        }
    }
    while (index > 0)
}

function changeSumField(rowno) {
    var TableSumfield, field, index, result
    result = ""
    TableSumfield = eval('document.all.SumField.innerHTML')
    do {
        index = TableSumfield.indexOf("SumFormula_")
        if (index <= 0)
            break;
        TableSumfield = TableSumfield.substring(index + 11, TableSumfield.length);
        field = TableSumfield.substring(0, TableSumfield.indexOf('>'));
        if (field.indexOf(' ') > 0) {
            field = field.substring(0, field.indexOf(' '));
        }
        if (field != "")
            result += 'window.document.all.ReadOnly' + field + rowno + '.innerText=eval(window.document.all.SumFormula_' + field + '.value),';
    }
    while (index > 0)
    return result;
}

function changeRowTotal(rowno, operand) {
    var Total, field, index;
    Total = eval('document.all.TotalRecord.innerHTML');
    do {
        index = Total.indexOf("Total_");
        if (index <= 0) break;
        Total = Total.substring(index + 6, Total.length);
        field = Total.substring(0, Total.indexOf(' '));

        if (operand == 1) {
            eval('window.document.all.Total_' + field + '.innerText =parseInt(window.document.all.Total_' + field + '.innerText.replace(",",""))+parseInt(document.all.ReadOnly' + field + rowno + '.innerText.replace(",",""))');
        }
        else {
            eval('window.document.all.Total_' + field + '.innerText =parseInt(window.document.all.Total_' + field + '.innerText.replace(",",""))-parseInt(document.all.ReadOnly' + field + rowno + '.innerText.replace(",",""))');
        }
        eval('window.document.all.Total_' + field + '.innerHTML ="<b>"+window.document.all.Total_' + field + '.innerText+"</b>"');
    }
    while (index > 0)
}

function changerowReadOnly(rowno, strGUID) {
    var index, substring, Length, ID, Bold, string, field, resultsumtable;
    substring = eval('document.all.rowEdit' + rowno + '.innerHTML');
    string = substring;
    changeRowTotal(rowno, 0);

    //Loop while Textbox still found
    do {
        Length = substring.length;
        index = substring.indexOf('textBoxStandard');
        if (index < 0)
            break;
        substring = substring.substring(index + 15, Length);
        Length = substring.length;
        index = substring.indexOf('name=');
        //Find name of Textbox
        substring = substring.substring(index + 5, Length);
        ID = substring.substring(0, substring.indexOf('>'));

        if (ID.indexOf(' ') > 0) {
            ID = ID.substring(0, ID.indexOf(' '));
        }
        field = ID.substring(0, ID.length - rowno.length);
        eval('var ' + field + ' =document.all.' + ID + '.value.replace(",","")');

        //Change RowReadOnly value with RowEdit value
        eval('window.document.all.ReadOnly' + ID + '.innerText=document.all.' + ID + '.value');

        if (eval('document.all.' + ID + '.value.replace(",","")') != eval('document.all.Record_' + ID + '.innerText.replace(",","")')) {
            Bold = true;
        }
    }
    while (index > 0)

    resultsumtable = changeSumField(rowno)
    do {
        index = resultsumtable.indexOf(",");
        if (index <= 0)
            break;
        eval(resultsumtable.substring(0, index));
        resultsumtable = resultsumtable.substring(index + 1, resultsumtable.length);
    }
    while (index > 0)
    changeRowTotal(rowno, 1);
    changerowReadOnlyFont(string, rowno, Bold);
}

function activateCalculate() {
}

function changeTextBox(strGUID, editFlag, GUIDPK) {

    // if current edit still open, close it
    if (document.all.currentEditGUID.value != "") {
        var rowEditEl = 'document.all.rowEdit' + document.all.currentEditGUID.value + ".style.display='none'";
        var rowReadOnlyEl = 'document.all.rowReadOnly' + document.all.currentEditGUID.value + ".style.display='inline'";
        //Change RowReadOnly value with rowEdit value
        changerowReadOnly(document.all.currentEditGUID.value, strGUID);
        eval(rowReadOnlyEl);
        eval(rowEditEl);
    }
    // save current
    document.all.currentEditGUID.value = strGUID;
    if (document.all.cfunctionlist.value.indexOf(GUIDPK) == -1) {
        document.all.cfunctionlist.value += GUIDPK + ',';
        document.all.crownolist.value += strGUID + ',';
    }

    // open rowEdit
    var curRowEdit = 'document.all.rowEdit' + strGUID + ".style.display='inline'";
    var curRowReadOnly = 'document.all.rowReadOnly' + strGUID + ".style.display='none'";
    if (editFlag == 1) {
        var index, ID;
        eval(curRowEdit);
        eval(curRowReadOnly);

        document.forms(0).rowclicked.value = strGUID;
        curRowEdit = eval('document.all.rowEdit' + strGUID + ".innerHTML");

        index = curRowEdit.indexOf('textBoxStandard');
        curRowEdit = curRowEdit.substring(index + 15, curRowEdit.length);
        index = curRowEdit.indexOf('name=');
        curRowEdit = curRowEdit.substring(index + 5, curRowEdit.length);
        ID = curRowEdit.substring(0, curRowEdit.indexOf('>'));
        if (ID.indexOf(' ') > 0) {
            ID = ID.substring(0, ID.indexOf(' '));
        }
        window.setTimeout('document.all.' + ID + '.focus();', 500);
    }
    // calculate for sub browse
    activateCalculate();
}

function subview(tableName, GUID, mode, cfunction) {
    runbeforesave();
    if (mode == 0)
        window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?mode=0&code=' + tableName + '&GUID=' + GUID;
    else if (mode == 1) {

        if (cfunction == 'add')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?new=1&mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        else if (cfunction == 'edit')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        else if (cfunction == 'save') {

            var requiredname, requiredtblvalue, validation, index;
            validation = '';

            //required field
            requiredname = document.forms(0).requiredname.value;
            requiredtblvalue = document.forms(0).requiredtblvalue.value;
            //alert(requiredtblvalue);
            //search UnValid input
            do {
                if (requiredtblvalue.indexOf(',') <= 0) break;
                if (document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).type != 'radio') {
                    if (document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).value == '') {
                        if (validation == '')
                            validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                        else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                    }
                } else { //radio
                    var radioobj = eval('document.forms(0).' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(',')));
                    var c = false;
                    for (i = 0; i <= radioobj.length - 1; i++) {
                        if (radioobj(i).checked) { c = true; break; }
                    }
                    if (!c) {
                        if (validation == '')
                            validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                        else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                    }
                }
                requiredtblvalue = requiredtblvalue.substring(requiredtblvalue.indexOf(',') + 1, requiredtblvalue.length);
                requiredname = requiredname.substring(requiredname.indexOf(',') + 1, requiredname.length);
            }
            while (requiredtblvalue.indexOf(',') > 0)

            if (validation == '')
                validation += manualvalidation();
            else
                validation += ',' + manualvalidation();

            document.forms(0).cfunctionlist.value = GUID;
            document.forms(0).cfunction.value = 'save';
            if (validation == '') {
                //document.forms(0).style.cursor = 'wait';
                document.forms(0).submit();
            }
            else
                showMessage(validation);
        }
        else if (cfunction == 'canceladd')
            window.document.all.SubView.innerHTML = "";
        else if (cfunction == 'cancelsave')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?mode=0&code=' + tableName + '&GUID=' + GUID;
    }

}

function subviewpage(vp, tableName, GUID, mode, cfunction) {   //alert(cfunction);
    runbeforesave();
    if (mode == 0) {
        window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&mode=0&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
    }
    else if (mode == 1) {   //alert(cfunction);
        if (cfunction == 'view')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&new=1&mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        if (cfunction == 'add')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&new=1&mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        else if (cfunction == 'edit')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        else if (cfunction == 'upload')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&new=1&mode=1&code=' + tableName + '&GUID=' + GUID + '&functiontext=' + cfunction;
        else if (cfunction.substring(0, 4) == 'save') {
            var requiredname, requiredtblvalue, validation, index;
            validation = '';

            //required field
            requiredname = document.forms(0).requiredname.value;
            requiredtblvalue = document.forms(0).requiredtblvalue.value;

            do {
                if (requiredtblvalue.indexOf(',') <= 0) break;
                if (document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).type != 'radio') {
                    var c1 = document.forms(0).item(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).value;
                    if (c1 == '') c1 = document.getElementById(requiredtblvalue.substring(0, requiredtblvalue.indexOf(','))).value;
                    if (c1 == '') {
                        if (validation == '')
                            validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                        else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                    }
                } else { //radio
                    var radioobj = eval('document.forms(0).' + requiredtblvalue.substring(0, requiredtblvalue.indexOf(',')));
                    var c = false;
                    for (i = 0; i <= radioobj.length - 1; i++) {
                        if (radioobj(i).checked) { c = true; break; }
                    }
                    if (!c) {
                        if (validation == '')
                            validation = 'You have to fill ' + requiredname.substring(0, requiredname.indexOf(','));
                        else validation += ', ' + requiredname.substring(0, requiredname.indexOf(','));
                    }
                }

                requiredtblvalue = requiredtblvalue.substring(requiredtblvalue.indexOf(',') + 1, requiredtblvalue.length);
                requiredname = requiredname.substring(requiredname.indexOf(',') + 1, requiredname.length);
            }
            while (requiredtblvalue.indexOf(',') > 0)
            //alert(requiredtblvalue);

            if (validation == '')
                validation += manualvalidation();
            else
                validation += ',' + manualvalidation();

            document.forms(0).cfunctionlist.value = GUID;
            document.forms(0).cfunction.value = cfunction;
            if (validation == '') {
                if (tableName == 'caUPLD') {
                    document.forms(0).item("cfunction").value = document.forms(0).item("cfunction").value.replace('save', 'upload');
                }
                document.forms(0).submit();
            }
            else {
                showMessage(validation.substr(0, validation.length - 1) + ".");
                setCursorDefault(this);
            }
        }
        else if (cfunction == 'canceladd') {
            //alert(document.all.DeliveryDate.value);
            document.getElementById(vp).innerHTML = "";
            //window.document.all[vp].innerHTML = "";
            setCursorDefault(this);
        }
        else if (cfunction == 'cancelsave')
            window.frames['frmMessage'].location = 'OPHCore/api/msg_subview.aspx?spage=' + vp + '&mode=0&code=' + tableName + '&GUID=' + GUID;
    }
    if (vp && !validation) {
        if (document.getElementById("SubView2"))
            if (document.getElementById("SubView2").style) {
                document.getElementById("SubView2").style.display = "none";
                document.getElementById("SubView2").innerHTML = "";
            }
        if (document.getElementById("SubView3"))
            if (document.getElementById("SubView3").style) {
                document.getElementById("SubView3").style.display = "none";
                document.getElementById("SubView3").innerHTML = "";
            }
        if (document.getElementById("SubView4"))
            if (document.getElementById("SubView4").style) {
                document.getElementById("SubView4").style.display = "none";
                document.getElementById("SubView4").innerHTML = "";
            }
        if (document.getElementById("SubView5"))
            if (document.getElementById("SubView5").style) {
                document.getElementById("SubView5").style.display = "none";
                document.getElementById("SubView5").innerHTML = "";
            }

        document.getElementById(vp).style.display = "inline";
    }
}

function iframeload() { }
function runbeforesave() { }
function iframewindowonload() { }


/***********************************************
* Textarea Maxlength script- © Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

function ismaxlength(obj) {
    var mlength = obj.getAttribute ? parseInt(obj.getAttribute("maxlength")) : ""
    if (obj.getAttribute && obj.value.length > mlength)
        obj.value = obj.value.substring(0, mlength)
}

function textboxRO(id) {
    try {
        top.document.getElementById(id).readOnly = true;
        top.document.getElementById(id).className = 'textBoxClearBorder';
    } catch (e) { }
}
function textboxHide(id) {
    try {
        document.getElementById("tr_" + id).style.display = "none";
    }
    catch (e) { }
}
function textboxShow(id) {
    try {
        document.getElementById("tr_" + id).style.display = "inline";
    }
    catch (e) { }
}

function checkboxRO(id) {
    try {
        top.document.getElementById(id).disabled = true;
    } catch (e) { }
}
function suggestRO(id) {
    try {
        top.document.getElementById(id + "_name").readOnly = true;
        top.document.getElementById(id + "_name_div").className = 'textBoxClearBorder';
        top.document.getElementById(id + "_name_button").style.display = "none";
    } catch (e) { }
}

function dateRO(id, enabled, checked) {
    var daysIndex = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    if (enabled)
        top.document.getElementById("check_" + id).disabled = "";
    else
        top.document.getElementById("check_" + id).disabled = "disabled";
    if (!(checked == undefined))
        enabled = checked;
    else
        if (top.document.getElementsByName(id)[0].value == '01/01/2000') {
            top.document.getElementById("check_" + id).checked = "";
            enabled = false;
        }
        else {
            checked = true;
            top.document.getElementById("check_" + id).checked = "checked";
        }
    if (!checked) {
        top.document.getElementsByName(id)[0].value = '01/01/2000';
        top.document.getElementsByName(id + "_Year_ID")[0].value = '2000';
        top.document.getElementsByName(id + "_Month_ID")[0].value = '0';
        top.document.getElementsByName(id + "_Day_ID")[0].value = '1';
    }

    if (enabled) {
        //try {
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").disabled = false;
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").disabled = false;
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").disabled = false;
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_ID_Link")) top.document.getElementById(id + "_ID_Link").style.display = 'inline';
        //} catch (e) { }
        if (top.document.getElementsByName(id)[0].value == '01/01/2000' && top.document.getElementsByName(id + "_Year_ID")[0].value == '2000') top.document.getElementsByName(id + "_Year_ID")[0].value = Today.getFullYear();
        if (top.document.getElementsByName(id)[0].value == '01/01/2000' && top.document.getElementsByName(id + "_Month_ID")[0].value == '0') top.document.getElementsByName(id + "_Month_ID")[0].value = Today.getMonth();
        if (top.document.getElementsByName(id)[0].value == '01/01/2000' && top.document.getElementsByName(id + "_Day_ID")[0].value == '1') top.document.getElementsByName(id + "_Day_ID")[0].value = Today.getDate();
        if (top.document.getElementsByName(id)[0].value == '01/01/2000') top.document.getElementsByName(id)[0].value = (Today.getMonth() + 1) + '/' + Today.getDate() + '/' + Today.getFullYear();
        var tgl = new Date().getDay();
        document.getElementsByName(id + 'DayName_ID')[0].value = daysIndex[tgl];
    }
    else {
        //try {
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").disabled = true;
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").disabled = true;
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").disabled = true;
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_ID_Link")) top.document.getElementById(id + "_ID_Link").style.display = 'none';
        //} catch (e) { }
    }
}
function sendProfile() {
    document.forms(0).item("isProfileEdit").value = "1";
    document.forms(0).submit();
}

function dateROR(id, enabled) {
    if (enabled) {
        //try {
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").disabled = false;
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").disabled = false;
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").disabled = false;
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").className = 'calendarDateInput';
        if (top.document.getElementById(id + "_ID_Link")) top.document.getElementById(id + "_ID_Link").style.display = 'inline';
        //} catch (e) { }
    }
    else {
        //try {
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").disabled = true;
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").disabled = true;
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").disabled = true;
        if (top.document.getElementById(id + "_Day_ID")) top.document.getElementById(id + "_Day_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_Month_ID")) top.document.getElementById(id + "_Month_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_Year_ID")) top.document.getElementById(id + "_Year_ID").className = 'calendarDateInputRO';
        if (top.document.getElementById(id + "_ID_Link")) top.document.getElementById(id + "_ID_Link").style.display = 'none';
        //} catch (e) { }
    }
}

//function setAsWelcomePage(curPage) {
//    try {
//        curPage = curPage.replace('&', '*').replace('&', '*').replace('&', '*').replace('&', '*');
//        window.frames['framesetAsWelcomePage'].location = "OPHCore/api/msg_general.aspx?mode=3&curPage=" + curPage;
//        //window.open('OPHCore/api/msg_general.aspx?mode=3&curPage=' + curPage);
//        //window.frames['frameBrowse'].location = "OPHCore/api/msg_general.aspx?mode=3&curPage=" + curPage
//        //        var div = document.getElementById("setAsWelcomePage");
//        //        document.getElementById(div).innerHTML = "<a class='labelUnder'>This page has been set as welcome page</a>";
//    }
//    catch (e) { }

//}


function startSideBarCollapser() {
    for (var i = 1; i < 9; i++) {
        $('.SideBarTitleCollapse' + i).collapser({
            target: '.SideBarTable' + i,
            targetOnly: 'table',
            effect: 'slide',
            changeText: 0
        });
    }
}

function startSubViewCollapser() {
    for (var i = 0; i < 9; i++) {
        $('.subviewcollapse' + i).collapser({
            target: 'next',
            targetOnly: 'div',
            effect: 'slide',
            changeText: 0,
            expandClass: 'expArrow',
            collapseClass: 'collArrow'
        });
    }
}

function ShowMap(reportName, parameter, n, t) {
    var parvalue1 = "";

    do {
        if (parameter.indexOf(',') > -1) {
            parid = parameter.substring(0, parameter.indexOf(','));
            parid1 = parid

            do {
                parid1 = parid1.replace('*', '');
            }
            while (parid1.indexOf('*') > -1)
            //parid1 = trim(parid1);
            if (parid1.substring(0, 1) == '#') {
                parid1 = parid1.replace("#", "");
                parid1 = parid1.replace("#", "");
                parvalue = parid1;
            }
            else {
                if (eval("document.forms(0).elements('" + parid1 + "').type") == 'checkbox') {
                    var r = (eval("document.forms(0).elements(" + parid1 + ").checked")) ? "1" : "0";
                    parvalue = "" + r + "";
                }
                else {
                    parvalue = eval("document.forms(0).elements('" + parid1 + "').value");
                }
                parid = parid.replace(parid1, parvalue);

            }
            parvalue1 += "''" + parvalue + "'',";
            parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
        }
        else {
            //alert(parameter.length); 
            if (parameter.length > 0) {
                do {
                    parameter = parameter.replace('*', '');
                }
                while (parameter.indexOf('*') > -1)
                parameter = trim(parameter);
                if (parameter.substring(0, 1) == '#') {
                    parameter = parameter.replace("#", "");
                    parameter = parameter.replace("#", "");
                    parvalue1 += "''" + parameter + "''";
                }
                else {
                    if (eval("document.forms(0).elements('" + parameter + "').type") == 'checkbox') {
                        var r = (eval("document.forms(0).elements(" + parameter + ").checked")) ? "1" : "0";
                        parvalue1 += "" + r + "";
                    }
                    else {
                        parvalue1 += "''" + eval("document.forms(0).elements('" + parameter + "').value") + "''";
                    }
                }
                parameter = parvalue1;
            }
            break;
        }
    }
    while (parameter.indexOf(',') > -2)
    parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
    //alert('../../Include/api/msg_rptDialog.aspx?parameter='+parameter+'&outputType=2'+'&reportName='+reportName);
    //window.frames['frmMessage'].location = 'OPHCore/api/msg_rptDialog.aspx?parameter=' + parameter + '&isPrintOnly=0&outputType=' + outputtype + '&reportName=' + reportName + '&titleName=' + titleName + '&subtitleName=' + subtitleName;


    // Read the data from example.xml
    var xmlFile = reportName + ".aspx?parameter=" + parameter + "&d=" + Date()
    downloadUrl(xmlFile, function (doc) {
        var xmlDoc = xmlParse(doc);
        if (xmlDoc.xml != '') {
            var markers = xmlDoc.documentElement.getElementsByTagName("marker");
            for (var i = 0; i < markers.length; i++) {
                // obtain the attribues of each marker
                var lat = parseFloat(markers[i].getAttribute("lat"));
                var lng = parseFloat(markers[i].getAttribute("lng"));
                if (i == 0) {
                    // create the map
                    var myOptions = {
                        zoom: 8,
                        center: new google.maps.LatLng(lat, lng),
                        mapTypeControl: true,
                        mapTypeControlOptions: { style: google.maps.MapTypeControlStyle.DROPDOWN_MENU },
                        navigationControl: true,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    }
                    map = new google.maps.Map(document.getElementById("map_canvas"),
                        myOptions);

                    google.maps.event.addListener(map, 'click', function () {
                        infowindow.close();
                    });
                }

                var point = new google.maps.LatLng(lat, lng);
                var html = markers[i].getAttribute("html");
                var label = markers[i].getAttribute("label");
                // create the marker
                var marker = createMarker(point, label, html);
            }
        }
        else { showMessage('No data available!') }
        // put the assembled side_bar_html contents into the side_bar div
        //document.getElementById("side_bar").innerHTML = side_bar_html;
    });
}

function PrintDirect(queryCode, parameter, outputtype, titleName, subtitleName, PathDPLX) {

    var parvalue1 = "";
    var parameter1 = parameter.length - 1;
    var parameter = parameter.substring(0, parameter1);

    do {
        if (parameter.indexOf(',') > -1) {
            parid = parameter.substring(0, parameter.indexOf(','));
            parid1 = parid

            do {
                parid1 = parid1.replace('*', '');
            }
            while (parid1.indexOf('*') > -1)
            if (parid1.substring(0, 1) == '#') {
                parid1 = parid1.replace("#", "");
                parid1 = parid1.replace("#", "");
                parvalue = parid1;
            }
            else {
                if (document.getElementById(parid1).type == 'checkbox') {
                    var r = document.getElementById(parid1).checked ? "1" : "0";
                    parvalue = "" + r + "";
                }
                else {
                    parvalue = document.getElementById(parid1).value;

                }
                parid = parid1.replace(parid1, parvalue);

            }

            if (outputtype == 1)
                parvalue1 += parid1 + ":''" + parvalue + "'',";
            else
                parvalue1 += parid1 + ":''" + parvalue + "'',";
            parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
        }
        else {
            if (parameter.length > 0) {
                do {
                    parameter = parameter.replace('*', '');
                }
                while (parameter.indexOf('*') > -1)
                if (parameter.substring(0, 1) == '#') {
                    parameter = parameter.replace("#", "");
                    parameter = parameter.replace("#", "");
                    parvalue1 += "''" + parameter + "''";
                }
                else {
                    if (eval("document.getElementById('" + parameter + "').type") == 'checkbox') {
                        var r = (eval("document.getElementById('" + parameter + "').checked")) ? "1" : "0";
                        if (outputtype == 1)
                            parvalue1 += parameter + ":" + r + "";
                        else
                            parvalue1 += parameter + ":" + r + "";
                    }
                    else {
                        if (outputtype == 1)
                            parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
                        else

                            parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
                    }
                }
                parameter = parvalue1;

            }
            break;
        }
    }
    while (parameter.indexOf(',') > -2)
    parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
    var ParentGUID = '';
    mode = (outputtype == 1) ? 'dplx' : 'gbox';
    if (outputtype == 3) ParentGUID = '&parentGUID=' + getQueryVariable('GUID');

    window.open('OPHCore/api/msg_rptDialog.aspx?' + mode + '=1&queryCode=' + queryCode + '&parameter=' + parameter + '&outputType=' + outputtype + '&' + ParentGUID + '&titleName=' + titleName + '&subtitleName=' + subtitleName + ' ' + Date());

}

function displayResult() {
    var x = document.getElementById("startdate").value;
    showMessage(x);
}

///////////////////////////////form function///////////////////////////////////////////////////////////////////
function back() {
    window.location = "index.aspx?env=back&code=" + getCode();
}
function saveCancel() {
    if (getGUID() == "00000000-0000-0000-0000-000000000000") back()
    else {
        $("input[type='text'], input[type='checkbox'], select").each(function () {
            var t = $(this);
            if ($(this).data("old") != undefined) {

                if ((t.prop("type") == "text" || t.prop("type") == "checkbox") && ($(this).val() != $(this).data("old")) ||
                    ((t.prop("type") == "select-one") && ($(this).data("value") != $(this).data("old")))) {

                    if (t.prop("type") == "text") $(this).val($(this).data("old"));
                    if (t.prop("type") == "checkbox") t.prop('checked', $(this).data("old"));
                    if (t.prop("type") == "select-one") $(this).data("value", $(this).data("old"));
                    //select
                    var newOption = new Option($(this).data("oldtext"), $(this).data("old"), true, true);
                    t.append(newOption).trigger('change');

                    //token
                    if ($(this).data("type") == 'tokenBox') {
                        var tokenCode = $(this).data("code");
                        var key = $(this).data("key");
                        var id = $(this).data("id");
                        var name = $(this).data("name");
                        var search = $(this).data("old");

                        var sURL = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=' + tokenCode + '&key=' + key + '&id=' + id + '&name=' + name;
                        var cURL = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=' + tokenCode + '&key=' + key + '&id=' + id + '&name=' + name + '&search=' + search;
                        var fieldName = $(this)[0].id
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

                                $('#button_save').hide();
                                $('#button_cancel').hide();
                                $('#button_save2').hide();
                                $('#button_cancel2').hide();
                                //$tokenInput(get, '');
                            }
                        });
                    }

                    $('#button_save').hide();
                    $('#button_cancel').hide();
                    $('#button_save2').hide();
                    $('#button_cancel2').hide();


                }
            }
        })
    }
}

function saveConfirm() {
    $("input[type='text'], input[type='checkbox'], select").each(function () {
        var t = $(this);
        if ($(this).data("old") != undefined) {

            if ((t.prop("type") == "text" || t.prop("type") == "checkbox") && ($(this).val() != $(this).data("old")) ||
                ((t.prop("type") == "select-one") && ($(this).data("value") != $(this).data("old")))) {

                if (t.prop("type") == "text" || t.prop("type") == "checkbox") $(this).data("old", $(this).val());
                if (t.prop("type") == "select-one") {
                    $(this).data("old", $(this).data("value"));
                    $(this).data("oldtext", t[0].options[t[0].selectedIndex].text);
                }
                $('#button_save').hide();
                $('#button_cancel').hide();
                $('#button_save2').hide();
                $('#button_cancel2').hide();
            }
        }
    })

}


function isGuid(value) {
    var regex = /[a-f0-9]{8}(?:-[a-f0-9]{4}){3}-[a-f0-9]{12}/i;
    var match = regex.exec(value);
    return match != null;
}

function checkrequired(Names) {
    var result = 'good'
    for (i = 0; i < Names.length - 1; i++) {
        var val = document.getElementsByName(Names[i])[0].value;

        if (val == '' || val == undefined) {
            result = document.getElementById(Names[i] + 'caption').innerHTML + ' need to be filled';
            break;
        }

    }

    return result;
}

function showChildForm(code, guid) {
    //clear other childform
    $(".browse-data").html("Please Wait...");

    var xsldoc = "OPHContent/themes/" + loadThemeFolder() + "/xslt/" + getPage() + "_childForm.xslt";
    var xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=view&GUID=" + guid
    showXML(code + guid, xmldoc, xsldoc, true, true, function () { });
    //setCookie("currentChild", code + guid);
}
function closeChildForm() {
    $('.browse-data').collapse("hide");
}

function autosuggestSetValue(SelectID, Code, CaptionID, CaptionName, CaptionKey, InitialValue) {
    var aj = $.ajax({
        url: "OPHCORE/api/msg_autosuggest.aspx",
        data: {
            search: InitialValue,
            code: Code,
            id: CaptionID,
            name: CaptionName,
            key: CaptionKey,
        },
        dataType: "json",
        success: function (data) {
            var newOption = new Option(data.results[0].text, data.results[0].id, true, true);
            $("#" + SelectID).append(newOption).trigger('change');
            //$("#" + SelectID).data("old", InitialValue);
            if (data.results[0].id = $("#" + SelectID).data("old")) $("#" + SelectID).data("oldtext", data.results[0].text);
        }
    });


    return aj;
}

function checkCB(checkboxname) {
    if ($("input[name='cb" + checkboxname + "'][type='checkbox']").is(":checked")) {
        $("input[name='cb" + checkboxname + "'][type='checkbox']").val(1);
        $("#" + checkboxname + "").val(1);
        //$("#" + checkboxname).attr("name", "")
    }
    else {
        $("input[name='cb" + checkboxname + "'][type='checkbox']").val(0);
        $("#" + checkboxname + "").val(0);
        //$("#" + checkboxname).attr("name", checkboxname)
    }
}


function changestateid(stateid) {
    setCookie('stateid', stateid, 0, 1, 0);
    setCookie('bSearchText', '', 0, 1, 0);
    loadContent(1);
}

function resetBrowseCookies() {
    //setCookie('stateid', '399', 0, 1, 0);
    setCookie('stateid', '', 0, 1, 0);
    setCookie('bSearchText', '', 0, 1, 0);

}

function searchText(e, searchvalue) {
    if (e.keyCode == 13) {
        setCookie('bSearchText', searchvalue, 0, 1, 0);
        loadContent(1);
    }
}
function searchTextChild(e, searchvalue, code) {
    if (e.keyCode == 13) {
        var bSearchText = searchvalue;

        var sqlfilter = document.getElementById("filter" + code.toLowerCase()).value;
        pageNo = (pageNo == undefined) ? 1 : pageNo;

        var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + sqlfilter + '&bPageNo=' + pageNo + '&bSearchText=' + bSearchText + '&date=' + getUnique();
        var divName = ['child' + String(code).toLowerCase()];
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];

        pushTheme(divName, xmldoc, xsldoc, true);

    }
}


function preview(flag, code, GUID, formid, t) {
    if (flag > 0) {
        var path = 'OPHCore/api/default.aspx?mode=preview&code=' + code + '&flag=' + flag + '&cfunctionlist=' + GUID;
        var thisForm = 'form';
        if (formid != undefined) thisForm = '#' + formid;
        var dataForm = $(thisForm).serialize()

        var dfLength = dataForm.length;


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
                var x = $(data).find("message").children().each(function () {
                    $(this).text();
                    if (document.getElementById(this.tagName)) {
                        if (document.getElementById(this.tagName).type == "checkbox") {
                            if ($(this).text() == "1") {
                                document.getElementById(this.tagName).checked = true;
                                document.getElementById(this.tagName).value = 1;
                            } else {
                                document.getElementById(this.tagName).checked = false;
                                document.getElementById(this.tagName).value = 0;
                            }
                        } else {
                            if (flag > 1 || $(this).text() != '') {

                                if (document.getElementById(this.tagName).type == 'select-one') {
                                    var newOption = new Option($(this.nextSibling).text(), $(this).text(), true, true);
                                    $("#" + this.tagName).append(newOption).trigger('change');

                                }

                                document.getElementById(this.tagName).value = $(this).text();

                            }
                            if ($(this).attr('disabled') == 'disabled') {

                                $('#' + this.tagName).attr('disabled', true)
                            }
                            if ($(this).attr('display') == 'none') {
                                textboxHide(this.tagName);
                                $('#' + this.tagName).parent().parent().hide()
                            }
                            else if ($(this).attr('display') == 'inline') {
                                $('#' + this.tagName).parent().parent().show()
                            }
                            //AddedBy eLs
                            if ($(this).attr('style')) {
                                var style = $(this).attr('style');
                                $('#' + this.tagName).attr('style', style);
                            }
                            if ($(this).attr('hide')) {
                                var hide = $(this).attr('hide');
                                var IdVal = this.tagName;
                                if (hide == 'true') {
                                    try { document.getElementById(IdVal).style.display = "none"; }
                                    catch (e) { }
                                    try { document.getElementById(IdVal + "_prefix").style.display = "none"; }
                                    catch (e) { }
                                    try { document.getElementById(IdVal + "_suffix").style.display = "none"; }
                                    catch (e) { }
                                    try { $('#' + this.tagName).attr('style', 'display:none;'); }
                                    catch (e) { }
                                }
                                else {
                                    try { document.getElementById(IdVal).style.display = "inline"; }
                                    catch (e) { }
                                    try { document.getElementById(IdVal + "_prefix").style.display = "inline"; }
                                    catch (e) { }
                                    try { document.getElementById(IdVal + "_suffix").style.display = "inline"; }
                                    catch (e) { }
                                    try { $('#' + this.tagName).attr('style', 'display:inline;'); }
                                    catch (e) { }
                                }
                            }
                            if ($(this).attr('disabled') == 'true' || $(this).attr('disabled') == 'dsiabled') {
                                try {
                                    document.getElementById(this.tagName).readOnly = true;
                                    document.getElementById(this.tagName).style.backgroundColor = "lavender";
                                    document.getElementById(this.tagName).style.opacity = "0.4";
                                    document.getElementById(this.tagName).style.filter = "alpha(opacity=40)";
                                    document.getElementById(this.tagName).value = "";
                                }
                                catch (e) { }
                            }
                            if ($(this).attr('disabled') == 'false') {
                                try {
                                    document.getElementById(this.tagName).readOnly = false;
                                    document.getElementById(this.tagName).style.backgroundColor = "white";
                                    document.getElementById(this.tagName).style.opacity = "1.0";
                                    document.getElementById(this.tagName).style.filter = "alpha(opacity=100)";
                                }
                                catch (e) { }
                            }
                            if ($(this).attr('readonly') == 'true') {
                                try {
                                    document.getElementById(this.tagName).readOnly = true;
                                }
                                catch (e) { }
                            }
                            if ($(this).attr('readonly') == 'false') {
                                try {
                                    document.getElementById(this.tagName).readOnly = false;
                                }
                                catch (e) { }
                            }
                            //EndBy eLs
                        }
                    }


                });
            }
        });
    }
    else {
        if (t) {
            if (($("#" + t.id).prop("type") == "select-one") && (t.options[t.selectedIndex].value != $("#" + t.id).data("value"))) {
                $("#" + t.id).data("value", t.options[t.selectedIndex].value);
            }
            $("input[type='text'], input[type='checkbox'], select").each(function () {
                var tx = $(this);
                if ($(this).data("old") != undefined) {

                    if (((tx.prop("type") == "text" || tx.prop("type") == "checkbox") && ($(this).val() != $(this).data("old")) && !tx[0].disabled) ||
                        ((tx.prop("type") == "select-one") && ($(this).data("value") != $(this).data("old")))) {
                        if ($(this).data("child") == 'Y') {
                            $('#child_button_save').show();
                            $('#child_button_cancel').show();
                            $('#child_button_save2').show();
                            $('#child_button_cancel2').show();

                        }
                        else {
                            $('#button_save').show();
                            $('#button_cancel').show();
                            $('#button_save2').show();
                            $('#button_cancel2').show();
                        }
                    }
                }
            })
        }
    }
}

function btn_function(code, GUID, action, page, location, formId, afterSuccess) {
    var pg = (page == "" || isNaN(page)) ? 0 : parseInt(page);

    if (location == undefined || location == "") { location = 0 }

    if (action == "formView") {
        loadForm(code, GUID);
    } else if (action == "save") {
        //location: 0 header; 1 child; 2 browse 
        saveFunction(code, GUID, location, formId, afterSuccess);
    } else {
        executeFunction(code, GUID, action, location);
    }
}

//function btn_trash(code, GUID, action, page, isChild) {
//    if (confirm('Are you sure you want to delete this data ?')) {
//        var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()
//        $.post(path, function (data) {
//            var msg = $(data).find('message').text();
//            if (msg == '') {
//                loadContent(page);
//                showMessage("Deleted Succesfully");
//            } else {
//                showMessage(msg);
//            }
//        });
//    }
//}

function btn_useractive(code, GUID, action, page) {
    if (confirm('Are you sure you want to change this user status ?')) {
        var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()
        $.post(path, function (data) {
            var msg = $(data).find('message').text();
            if (msg == '') {
                loadContent(page);
                showMessage("Changed Succesfully");
            } else {
                showMessage(msg);
            }
        });
    }
}
//function btn_force(code, GUID, action, page) {
//    if (confirm('Are you sure you want to close this data ?')) {
//        var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()

//        $.post(path, function (data) {
//            var msg = $(data).find('message').text();
//            if (msg == '') {
//                loadContent(page);
//                showMessage("Closed Succesfully");
//            } else {
//                showMessage(msg);
//            }
//        });
//    }
//}
//function btn_execute(code, GUID, action, page) {
//    if (confirm('Are you sure you want to Approve this data ?')) {
//        var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()

//        $.post(path, function (data) {
//            var msg = $(data).find('message').text();
//            if (msg == '' || msg == '2Approval Succesfully') {
//                loadContent(page);
//                showMessage("Approve Succesfully");
//            } else {
//                showMessage(msg);
//            }
//        });
//    }
//}
function executeFunction(code, GUID, action, location) {
    var successmsg = ''
    if (action == 'execute') {
        successmsg = 'Approve Succesfully'
    } else if (action == 'force') {
        successmsg = 'Close Succesfully'
    } else if (action == 'inactivate') {
        action = "delete"
        successmsg = 'Inactivate Succesfully'
    } else if (action == 'delete') {
        successmsg = 'Delete Succesfully'

    } else if (action == 'restore') {
        successmsg = 'Restore Succesfully'
    } else if (action == 'wipe') {
        successmsg = 'Wipe Succesfully'
    }

    var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment&unique=' + getUnique()

    if (location == undefined || location == "") { location = 0 }
    if (action=='delete' && confirm("You are about to delete this record. Are you sure?") == 1) {
        $.post(path, function (data) {
            var msg = $(data).find('message').text();
            if (msg == '' || msg == 'Approval Succesfully') {
                if (location == 1) {
                    $("#tr1_" + code + GUID).remove();
                    $("#tr2_" + code + GUID).remove();
                }
                else {
                    if (action = 'delete' && location == 0) {
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
//SaveData('taPCS1','cartForm', 'index.aspx?code=tapcs3')
function saveFunction(code, guid, location, formId, afterSuccess) {
    var tblnm = code
    requiredname = document.getElementsByName(tblnm + "requiredname")[0];
    var result
    if (requiredname != undefined) {
        requiredname = requiredname.value;
        requiredname = requiredname.substring(1, requiredname.length - 1);
        result = checkrequired(requiredname.split(';'));
    } else {
        result = 'good';
    }


    //if (location == undefined || location == "") { location = 0 }
    //console.log(requiredname);
    //var result = checkrequired(requiredname.split(';'));
    //console.log(result);

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

        var other_data = $(thisForm).serializeArray();
        $.each(other_data, function (key, input) {
            data.append(input.name, input.value);
        });

        //$('#' + formid).serialize()

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
            //var msg = $(data).children().find("message").text();
            //var retguid = $(data).children().find("guid").text();
            //if (location == 1) {
            //    var pkfield = document.getElementById("PKSAVE" + code).value;
            //    var pkvalue = document.getElementById("PK" + code).value;
            //    var parentkey = document.getElementById("PKID").value.split('child').join('');
            //}
            //if (retguid != guid && location == 0) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
            //else if (retguid != guid && location == 1) {
            //    xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
            //    preview(1, code, guid, formId + code);
            //    //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
            //    loadChild(code, pkfield, pkvalue, 1)

            //}
            //else if (msg != "") {
            //    //compatible with load version
            //    if (isGuid(msg) && location == 0) {
            //        window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + msg;
            //    }
            //        //compatible with load version
            //    else if (isGuid(msg) && location == 1) {
            //        xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
            //        preview(1, code, msg, formId + code);
            //        //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
            //        loadChild(code, pkfield, pkvalue, 1)
            //    }
            //    else {
            //        showMessage(msg);
            //    }
            //}
            //else {
            //    if (location == 0) {
            //        //location.reload();
            //        saveConfirm();
            //    } else {
            //        xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
            //        //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
            //        loadChild(code, parentkey, pkvalue, 1)
            //    }
            //}

            if (typeof afterSuccess == "function") afterSuccess(data);

        });
    }
    else
        showMessage(result);

}
function loadReport(qCode, f) {
    qCode = (qCode == "") ? getCode() : qCode;
    var xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode;
    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '.xslt';
    showXML('contentWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });

    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '_sidebar.xslt';
    var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();
    showXML('sidebarWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });

}

function genReport(code, parameter, outType, query, reportName) {
    if (parameter.indexOf(':') < 0) {
        var parvalue1 = "";
        var parameter = parameter.substring(0, (parameter.length - 1));
        do {
            if (parameter.indexOf(',') > -1) {
                parid = parameter.substring(0, parameter.indexOf(','));
                parid1 = parid

                do {
                    parid1 = parid1.replace('*', '');
                }
                while (parid1.indexOf('*') > -1)
                if (parid1.substring(0, 1) == '#') {
                    parid1 = parid1.replace("#", "");
                    parid1 = parid1.replace("#", "");
                    parvalue = parid1;
                }
                else {
                    if (document.getElementById(parid1).type == 'checkbox') {
                        var r = document.getElementById(parid1).checked ? "1" : "0";
                        parvalue = "" + r + "";
                    }
                    else {
                        parvalue = document.getElementById(parid1).value;

                    }
                    parid = parid1.replace(parid1, parvalue);

                }

                if (outType == 1)
                    parvalue1 += parid1 + ":''" + parvalue + "'',";
                else
                    parvalue1 += parid1 + ":''" + parvalue + "'',";
                parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
            }
            else {
                if (parameter.length > 0) {
                    do {
                        parameter = parameter.replace('*', '');
                    }
                    while (parameter.indexOf('*') > -1)
                    if (parameter.substring(0, 1) == '#') {
                        parameter = parameter.replace("#", "");
                        parameter = parameter.replace("#", "");
                        parvalue1 += "''" + parameter + "''";
                    }
                    else {
                        if (eval("document.getElementById('" + parameter + "').type") == 'checkbox') {
                            var r = (eval("document.getElementById('" + parameter + "').checked")) ? "1" : "0";
                            if (outType == 1)
                                parvalue1 += parameter + ":" + r + "";
                            else
                                parvalue1 += parameter + ":" + r + "";
                        }
                        else {
                            if (outType == 1)
                                parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
                            else
                                parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
                        }
                    }
                    parameter = parvalue1;

                }
                break;
            }
        }
        while (parameter.indexOf(',') > -2)
    }
    parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
    var ParentGUID = '';
    mode = (outType == 1) ? 'dplx' : 'gbox';
    if (outType == 3) ParentGUID = '&parentGUID=' + getQueryVariable('GUID');

    window.open('OPHCore/api/msg_rptDialog.aspx?' + mode + '=1&code=' + code + '&parameter=' + parameter + '&outputType=' + outType + '&query=' + query + '&reportName=' + reportName);
}

function childPageNo(pageid, code, currentpage, totalpages) {
    var result = "";

    var before = "";
    var after = "";
    var parentKey = '&quot;' + String(code).substring(2, 6) + 'GUID&quot;';
    var guid = '&quot;' + getQueryVariable("GUID") + '&quot;';
    var code = '&quot;' + code + '&quot;';

    if (currentpage != 1) result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 1) + ")'>&#171;</a></li>";
    if (parseInt(currentpage) - 2 > 0)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 2) + ")'>" + (parseInt(currentpage) - 2) + "</a></li>";

    if (parseInt(currentpage) - 1 > 0)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) - 1) + ")'>" + (parseInt(currentpage) - 1) + "</a></li>";

    result += "<li><a style ='background-color:#3c8dbc;color:white;'href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + currentpage + ")'>" + currentpage + "</a></li>";

    if (parseInt(currentpage) + 1 <= totalpages)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 1) + ")'>" + (parseInt(currentpage) + 1) + "</a></li>";
    if (parseInt(currentpage) + 2 <= totalpages)
        result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 2) + ")'>" + (parseInt(currentpage) + 2) + "</a></li>";

    if (parseInt(currentpage) != totalpages) result += "<li><a href='javascript:loadChild(" + code + "," + parentKey + "," + guid + "," + (parseInt(currentpage) + 1) + ")'>&#187;</a></li>";

    result += "<li>&nbsp;&nbsp;&nbsp;</li>"

    var combo = "<li><select style ='background:#fafafa;color:#666;border:1px solid #ddd;height:30px;'onchange='loadChild(" + code + "," + parentKey + "," + guid + ",this.value)'>";
    for (var i = 1; i <= totalpages; i++) {
        combo += "<option value =" + i + " " + (currentpage == i ? "selected" : "") + ">" + i + "</option>";
    };

    combo += '</select></li>';

    result += combo;


    $('#' + pageid).html(result);

}
function SaveData(code, formid, locations, GUID) {
    if (GUID != undefined && GUID != '') { GUID = '&cfunctionlist=' + GUID; }
    else { GUID = '' }
    var path = 'OPHCore/api/default.aspx?mode=save&code=' + code + GUID
    var id = "#" + formid
    //$.post(path, $(id).serialize());
    var dataForm = $(id).serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.split('%3C').join('%26lt%3B');

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
            var result = $(data).find("message").text();
            if (result) {
                document.getElementById("popupMsgContent").innerHTML = result;
                $("#popupMsg").show("slow")
            } else {
                if (getCode().toLowerCase() == 'tapcs2') {
                    //alert("test");
                    setCookie("cartID", "", 0, 0, 0);
                    location.replace("index.aspx?env=front&code=tapcs3");
                } else {
                    window.location.reload();
                }
            }
        }
    });

}

function SignOut() {

    var path = 'OPHCore/api/default.aspx?mode=signout' + '&date=' + getUnique();
    setCookie("cartID", "", 0, 0, 0);
    setCookie("isLogin", "0", 0, 1, 0);
    $.post(path).done(window.location.reload());

}

//use for detecting screen size : xs,sm, md, lg
function isBreakpoint(alias) {
    return $('.device-' + alias).is(':visible');
}
var waitForFinalEvent = function () { var b = {}; return function (c, d, a) { a || (a = "I am a banana!"); b[a] && clearTimeout(b[a]); b[a] = setTimeout(c, d) } }();
var fullDateString = new Date();

//$(window).resize(function () {
//    waitForFinalEvent(function () {

//        if (isBreakpoint('xs')) {
//            $('.someClass').css('property', 'value');
//        }

//    }, 300, fullDateString.getTime())
//});
function goHome() {
    window.location = 'index.aspx?env=' + getQueryVariable('env');
}