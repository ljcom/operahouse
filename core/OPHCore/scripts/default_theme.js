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

function getOrder() {
    if (getCookie("sortOrder") == undefined || getCookie("sortOrder") == "") {
        if (getQueryVariable("sortOrder") == undefined || getQueryVariable("sortOrder") == "") {
            return ""
        } else {
            return getQueryVariable("sortOrder")
        }
    } else {
        return getCookie("sortOrder")
    }
    return (getQueryVariable("sortOrder") == undefined ? (getCookie("sortOrder") == undefined ? "" : getCookie("sortOrder")) : getQueryVariable("sortOrder"))
}

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

//interface
function loadContent(nbpage, f) {
    //main content
    if (lastCode() != getCode()) {
        setCookie('sqlFilter', "", 0, 0, 0);
        setCookie('sortOrder', "", 0, 0, 0);
        setCookie('lastCode', getCode(), 0, 0, 15);
    }

    if (getCode().toLowerCase() == 'dumy')
        var xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
    else
        var xmldoc = 'OPHCore/api/default.aspx?mode=' + getMode() + '&code=' + getCode() + '&GUID=' + getGUID() + '&stateid=' + getState() + '&bPageNo=' + nbpage + '&bSearchText=' + getSearchText() + '&sqlFilter=' + getFilter() + '&sortOrder=' + getOrder() + '&date=' + getUnique();

    var divname = ['contentWrapper'];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];

    //sidebar
    divname.push('sidebarWrapper');
    xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '_sidebar.xslt');

    pushTheme(divname, xmldoc, xsldoc, true);
}//

function loadChild(code, parentKey, GUID, pageNo, mode, pcode) {
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
    }
    d = '<div><div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child' + code + GUID + '"></div></div>';
    if ($('#child' + code + GUID).length == 0) {
        $('#tr2_' + pcode + GUID).children("td").append(d);
    }
    pageNo = (pageNo == undefined) ? 1 : pageNo;

    var xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + '&date=' + getUnique();

    var divName = ['child' + String(code).toLowerCase() + GUID];
    //if (code == 'modlinfo' || code == 'modlcolminfo' || code =='modlcolm')
    if (mode == 'inline')
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childInline.xslt"];
    else
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];

    pushTheme(divName, xmldoc, xsldoc, true);

    //$('#' + code).on('show.bs.collapse', '.collapse', function () {
    //    $('#' + code).find('.collapse.in').collapse('hide');

    //});

    //showXML(divName, xmldoc, xsldocs, true, true, function () { });
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


function loadReport(qCode, tcode, f) {
    qCode = (qCode == "") ? getCode() : qCode;
    tcode = (tcode == undefined) ? getQueryVariable("tcode") : tcode;
    var xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + ((tcode != undefined) ? '&tcode=' + tcode : '') + '&unique=' + getUnique();
    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '.xslt';
    showXML('contentWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });

    var xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + ((tcode != undefined) ? '&tcode=' + tcode : '') + '&GUID=' + getGUID() + '&unique=' + getUnique();
    var xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '_sidebar.xslt';
    //var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();
    showXML('sidebarWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });

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


//childform

function showChildForm(code, guid, parent) {
    var divnm = [code + guid];
    //clear other childform
    if (!$('#' + code + guid).is(":visible")) {

        $("#" + divnm).html("Please Wait...");

        var xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=form&GUID=" + guid

        var xsldoc = ["OPHContent/themes/" + loadThemeFolder() + "/xslt/" + getPage() + "_childForm.xslt"];
        pushTheme(divnm, xmldoc, xsldoc, true, function () {
            $('#' + code + guid).collapse('show');
            // $('#' + code + guid).collapse({ parent: '#' + parent, toggle: true });
            // $('#' + code + guid).collapse('toggle');
        });
        //$('#' + code).find('.collapse.in').collapse('hide');
        //$('#' + code).children().find('.collapse.in').collapse('hide');
        $('#' + code + guid).parent().parent().parent().children().find('.collapse.in').collapse('hide');
    }
    else {
        $('#' + code + guid).collapse({ parent: '#' + guid, toggle: true });
        $('#' + code + guid).collapse('toggle');
        $("#" + divnm).html("");
    }
    //setCookie("currentChild", code + guid);
}
function closeChildForm(code, guid) {
    var divnm = [code + guid];
    $('#' + divnm).collapse("hide");
}

//functions

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

function saveFunction(code, guid, location, formId, afterSuccess) {

    saveFunction1(code, guid, location, formId, null, afterSuccess);
}

function saveFunction1(code, guid, location, formId, dataFrm, afterSuccess) {
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
        if (dataFrm == null) {
            var data = new FormData();

            if ($(':file').length > 0) {
                $.each($(':file')[0].files, function (key, value) {
                    data.append(key, value);
                });
            }
            var thisForm = 'form';
            if (formId != undefined) thisForm = '#' + formId;
            if (location == 30) { //child and gchildren
                //move to celljs
            } else {
                var other_data = $(thisForm).serializeArray();
                $.each(other_data, function (key, input) {
                    var newVal = input.value;
                    newVal = newVal.replace(/</g, '&lt;');
                    newVal = newVal.replace(/>/g, '&gt;');
                    data.append(input.name, newVal);
                });
            }
        }
        else {
            var data = new FormData();
            dataFrm.split('&').forEach(function (i) {
                d = i.split('=');
                data.append(d[0], d[1]);
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

function preview(flag, code, GUID, formid, t) {

    previewFunction(flag, code, GUID, formid, null, t);

}

function previewFunction(flag, code, GUID, formid, dataFrm, t, afterSuccess) {
    if (flag == undefined) flag = 1;
    if (GUID == undefined) GUID = "00000000-0000-0000-0000-000000000000"
    if (flag > 0) {
        var path = 'OPHCore/api/default.aspx?mode=preview&code=' + code + '&flag=' + flag + '&cfunctionlist=' + GUID;
        var thisForm = 'form';
        if (dataFrm == null) {
            if (formid != undefined) thisForm = '#' + formid;
             dataFrm = $(thisForm).serialize()

            //var dfLength = dataFrm.length;
            //dataFrm = dataFrm.substring(0, dfLength);
            //dataFrm = dataFrm.split('%3C').join('%26lt%3B');
        }
        //else {
        var dataForm = new FormData();
        dataFrm.split('&').forEach(function (i) {
            d = i.split('=');
            dataForm.append(d[0].toString(), d[1].toString());
        });
        //} 


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
                                    var checktext = $(this.nextSibling)[0]
                                    if (checktext == this.tagName + '_name') {
                                        var newOption = new Option($(this.nextSibling).text(), $(this).text(), true, true);
                                        $("#" + this.tagName).append(newOption).trigger('change');
                                    } else {
                                        autosuggestSetValue(this.tagName, code, this.tagName, this.textContent);
                                    }
                                } else {
                                    document.getElementById(this.tagName).value = $(this).text();
                                }
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
                    if (typeof afterSuccess == "function") afterSuccess(data);

                });
            }
        });
    }
    else {
        checkChanges(t);
    }
}

function checkChanges(t) {
    if (t) {
        if (($("#" + t.id).prop("type") == "select-one") && (t.options[t.selectedIndex].value != $("#" + t.id).data("value"))) {
            $("#" + t.id).data("value", t.options[t.selectedIndex].value);
        }
        $("input[type='text'], input[type='checkbox'], textarea, select").each(function () {
            var tx = $(this);
            if ($(this).data("old") != undefined) {

                if (((tx.prop("type") == "text" || tx.prop("type") == "checkbox") && ($(this).val() != $(this).data("old")) && !tx[0].disabled) ||
                    ((tx.prop("type") == "select-one") && ($(this).data("value") != $(this).data("old")))) {
                    if ($(this).data("child") == 'Y') {
                        $('#child_button_addSave').show();
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

function saveCancel() {
    if (getGUID() == "00000000-0000-0000-0000-000000000000") back()
    else {
        $("input[type='text'], input[type='checkbox'], textarea, select").each(function () {
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
            } else {
                $('#button_save').hide();
                $('#button_cancel').hide();
                $('#button_save2').hide();
                $('#button_cancel2').hide();
            }
        })
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

    if (action == "delete" && location == 40) {
        if (isAction == 1) {
            preview(1, code, GUID, "form" + code, null);
        }
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
                    var g = GUID.split(",");
                    g.forEach(function (i) {
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

function downloadModule(code, exportMode) {
    window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&code=' + code + '&parameter=&outputType=1&exportMode=' + exportMode);
}

function downloadChild(code, t) {
    var titleName = '';
    var subtitleName = '';

    ParentGUID = $(t).parent().parent().parent().parent().parent().parent().parent().data("parentguid");
    if (ParentGUID == undefined) ParentGUID = getQueryVariable('GUID');
    ParentGUID = '&parentGUID=' + ParentGUID;
    window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&code=' + code + '&parameter=&outputType=3&' + ParentGUID + '&titleName=' + titleName + '&subtitleName=' + subtitleName + ' ' + Date());
}

//other

function storeHash(code, anchor) {
    setCookie('hash_' + code, anchor, 1);
}
function getHash(code) {
    hash = getCookie('hash_' + code);
    if (hash != '') {
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