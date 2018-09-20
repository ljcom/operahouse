﻿var form_added = false, form_edited = false;
var themeXML;

function initTheme(bCode, bGUID, guestID, f) { //bmode, bcode, bguid hanya dipakai kalau mau pindah lokasi saja
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();
    if (bCode != undefined) setCookie('code', bCode, 0, 1, 0);
    if (bGUID != undefined) setCookie('GUID', bGUID, 0, 1, 0);
    var tcode = getQueryVariable('tcode');
    setCookie('guestID', guestID, 7, 0, 0);

    var xmldoc = '';
    try {
        var pathPage = 'index.aspx?mode=' + getMode();
        if (getCode().toLowerCase() === 'dumy' || getCode().toLowerCase() === '404') // || getCode().toLowerCase() === 'login')
            xmldoc = 'OPHContent/themes/' + loadThemeFolder() + '/sample.xml';
        else
            xmldoc = 'OPHCore/api/default.aspx?mode=master&code=' + getCode() + '&stateid=' + getState();// + unique;

        if (tcode != undefined)
            xmldoc = xmldoc + '&tcode=' + tcode;

        var divname = ['frameMaster'];
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '.xslt'];

        if ((getGUID() === '' || getGUID() == undefined) && getCode().toLowerCase() !== 'login') {
            $.get('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_sidebar.xslt').done(function () {
                divname.push('sidebarWrapper');
                xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_sidebar.xslt');

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
    var mode = getQueryVariable('mode') == undefined ? '' : getQueryVariable('mode').toLowerCase();
    var ret = "";

    if (mode === 'export') {
        ret = 'export';
    } else {
        if (getGUID() && getGUID !== '')
            ret = 'form';
        else
            ret = 'browse';
    }
    return ret;
    //return (getGUID() === '' || getGUID() == undefined) ? 'browse' : 'form'
}

function getCode() { return getQueryVariable("code") == undefined ? getCookie("code") : getQueryVariable("code"); }

function lastCode() { return getCookie('lastCode'); }

function getGUID() { return getCookie('GUID') == undefined || getCookie('GUID') === "" ? getQueryVariable("GUID") : getQueryVariable("GUID"); }

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
    setCookie('bSearchText', '');
    loadContent(1);
}


function getSearchText() { return getQueryVariable("bSearchText") == undefined ? getCookie('bSearchText') : getQueryVariable("bSearchText"); }

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
    if (h.length < 2) day = '0' + h;
    if (n.length < 2) day = '0' + n;
    if (s.length < 2) day = '0' + s;

    return [year, month, day, h, n, s].join('');
}

//interface
function loadContent(nbpage, f) {
    var xmldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

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

    var divname = ['contentWrapper'];
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];

    //sidebar
    divname.push('sidebarWrapper');
    xsldoc.push('OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '_sidebar.xslt');

    setTimeout(function () { pushTheme(divname, xmldoc, xsldoc, true); }, 100);
}//

function loadChild(code, parentKey, GUID, pageNo, mode, pcode) {
    var xmldoc;
    var xsldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

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
    d = '<div><div class="box box-solid box-default" style="box-shadow:0px;border:none" id="child' + code + GUID + '"></div></div>';
    if ($('#child' + code + GUID).length == 0) {
        $('#tr2_' + pcode + GUID).children("td").append(d);
    }
    pageNo = pageNo == undefined ? 1 : pageNo;

    xmldoc = 'OPHCORE/api/default.aspx?code=' + code + '&mode=browse&sqlFilter=' + parentKey + '=' + "'" + GUID + "'&bPageNo=" + pageNo + unique;

    var divName = ['child' + String(code).toLowerCase() + GUID];
    //if (code === 'modlinfo' || code === 'modlcolminfo' || code =='modlcolm')
    if (mode === 'inline')
        xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childInline.xslt"];
    else if (mode != undefined && mode.indexOf('custom') >= 0)
        xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_" + mode + ".xslt"];
    else
        xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];

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

function loadReport(qCode, tcode, f) {
    var xmldoc;
    var xsldoc;
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    qCode = (qCode === "") ? getCode() : qCode;
    tcode = (tcode == undefined) ? getQueryVariable("tcode") : tcode;
    xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + ((tcode != undefined) ? '&tcode=' + tcode : '') + unique;
    xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '.xslt';
    showXML('contentWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f === "function") f();
    });

    xmldoc = 'OPHCore/api/default.aspx?mode=report' + '&code=' + qCode + ((tcode != undefined) ? '&tcode=' + tcode : '') + '&GUID=' + getGUID() + unique;
    xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/report_' + getMode() + '_sidebar.xslt';
    //var xmldoc = 'OPHCore/api/default.aspx?mode=report&code=' + getCode() + '&GUID=' + getGUID() + '&date=' + getUnique();
    showXML('sidebarWrapper', xmldoc, xsldoc, true, true, function () {
        if (typeof f === "function") f();
    });

}

function showMessage(msg, mode, fokus, afterMessage) {
    var msgType;
    if (mode == 1) msgType = 'notice';
    else if (mode == 2) msgType = 'success';
    else if (mode == 4) msgType = 'error';
    else if (mode == 3) msgType = 'warning';
    else msgType = 'notice';

    if (msg === '' && (mode == 4 || mode == 3)) msg = 'Time out.';

    $("#notiTitle").text(msgType);
    $("#notiContent").text(msg);
    $("#notiModal").modal();

    if (fokus || afterMessage) {
        try {
            document.getElementById('notiBtn').onclick = function () {
                if (fokus) $(fokus).focus();
                if (typeof afterMessage === "function") afterMessage();
            };
        }
        catch (e) {
            //
        }
    }
}

function rejectPopup(code, GUID, action, page, location, formId, afterSuccess) {

    $("#rejectModal").modal();
    document.getElementById('rejectComment').onkeyup = function () {
        $('#rejectBtn').css('visibility', $('#rejectComment').val() !== '' ? 'visible' : 'hidden');
    };

    document.getElementById('rejectBtn').onclick = function () {
        var comment = $('#rejectComment').val();
        btn_function(code, GUID, action, page, location, formId, comment, afterSuccess);
    };

}

//childform

function showChildForm(code, guid, parent) {
    var divnm = [code + guid];
    //clear other childform
    if (!$('#' + code + guid).is(":visible")) {

        $("#" + divnm).html("Please Wait...");

        var xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=form&GUID=" + guid;

        var xsldoc = ["OPHContent/themes/" + loadThemeFolder() + "/xslt/" + getPage() + "_childForm.xslt"];
        pushTheme(divnm, xmldoc, xsldoc, true, function () {
            $('#' + code + guid).collapse('show');
            var form = 'form' + code;
            //preview(1, code, guid, form, this);
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
    var arGUID;

    var divnm = [code + guid];
    $('#' + divnm).collapse("hide");
}

//functions

function btn_function(code, GUID, action, page, location, formId, comment, afterSuccess) {
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, browse anak:30, browse form:40

    var pg = (page === "" || isNaN(page)) ? 0 : parseInt(page);

    if (location == undefined || location === "") { location = 20; }

    if (action === "formView") {
        loadForm(code, GUID);
    } else if (action === "save") {
        //location: 0 header; 1 child; 2 browse 
        //location: browse:10, header form:20, browse anak:30, browse form:40
        saveFunction(code, GUID, location, formId, afterSuccess);
    } else {
        if (GUID === null || GUID === '') {
            if (isIE()) {
                arGUID = [].slice.call($("input:checked").not("#pinnedAll").map(function () { return this.dataset.guid; }));
            } else {
                arGUID = Array.from($("input:checked").not("#pinnedAll").map(function () { return this.dataset.guid; }));
            }
            GUID = arGUID.join();
        }

        executeFunction(code, GUID, action, location, null, null, comment);
    }
}

function saveFunction(code, guid, location, formId, afterSuccess) {
    saveFunction1(code, guid, location, formId, null, afterSuccess);
}

function saveFunction1(code, guid, location, formId, dataFrm, afterSuccess) {
    var tblnm = code;
    var data;

    requiredname = document.getElementsByName(tblnm + "requiredname")[0];
    var result;
    var idReq;
    if (requiredname != undefined) {
        requiredname = requiredname.value;
        if (requiredname !== '' && requiredname != undefined) {
            result = checkrequired(requiredname.split(', '), 'good');
            idReq = checkrequired(requiredname.split(', '), 'id');
        } else {
            result = 'good';
        }
    } else {
        result = 'good';
    }

    if (result === 'good') {
        if (dataFrm === null) {
            data = new FormData();
            var thisForm = (formId != undefined) ? '#' + formId : 'form';

            if ($(thisForm + ' :file').length > 0) {
                $.each($(thisForm + ' :file')[0].files, function (key, value) {
                    data.append(key, value);
                });
            }
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
            data = new FormData();
            dataFrm.split('&').forEach(function (i) {
                d = i.split('=');
                var newVal = d[1];
                newVal = newVal.replace(/</g, '&lt;');
                newVal = newVal.replace(/>/g, '&gt;');
                data.append(d[0], newVal);
            });
        }

        //data.append('code', code);
        data.append('mode', 'save');
        data.append('cfunctionlist', guid);
        //data.append('guid', guid);
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
            if (typeof afterSuccess === "function") afterSuccess(data);
        });
    }
    else {
        if (location == 50 || location === '50') { //saveModalForm
            $('#notiModal').data("message", result);
            $('#notiModal').data("colname", idReq);
            if (typeof afterSuccess === "function") afterSuccess(data);
        } else {
            if (idReq) showMessage(result, '0', idReq);
            else showMessage(result);
        }
    }
}

function preview(flag, code, GUID, formid, t) {

    previewFunction(flag, code, GUID, formid, null, t);

}

function previewFunction(flag, code, GUID, formid, dataFrm, t, afterSuccess) {
    if (flag == undefined) flag = 1;
    if (GUID == undefined) GUID = "00000000-0000-0000-0000-000000000000";
    if (flag > 0) {

        if (dataFrm === null) {
            if (formid != undefined) thisForm = '#' + formid;
            dataFrm = $(thisForm).serialize();

            //var dfLength = dataFrm.length;
            //dataFrm = dataFrm.substring(0, dfLength);
            //dataFrm = dataFrm.split('%3C').join('%26lt%3B');
        }
        //else {
        var dataForm = new FormData();
        dataFrm.split('&').forEach(function (i) {
            d = i.split('=');
            var newVal = d[1];
            newVal = newVal.replace(/</g, '&lt;');
            newVal = newVal.replace(/>/g, '&gt;');
            dataForm.append(d[0].toString(), d[1].toString());
        });
        //} 
        dataForm.append('mode', 'preview');
        //dataForm.append('code', code);
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
                    if (document.getElementById(this.tagName)) {
                        if (document.getElementById(this.tagName).type === "checkbox") {
                            if ($(this).text() === "1") {
                                document.getElementById(this.tagName).checked = true;
                                document.getElementById(this.tagName).value = 1;
                            } else {
                                document.getElementById(this.tagName).checked = false;
                                document.getElementById(this.tagName).value = 0;
                            }
                        } else {
                            if (flag > 1 || $(this).text() !== '') {

                                if (document.getElementById(this.tagName).type === 'select-one') {
                                    var checktext = $(this.nextSibling)[0];
                                    if (checktext === this.tagName + '_name') {
                                        var newOption = new Option($(this.nextSibling).text(), $(this).text(), true, true);
                                        $("#" + this.tagName).append(newOption).trigger('change');
                                    } else {
                                        var defer = [];
                                        autosuggestSetValue(defer, this.tagName, code, this.tagName, this.textContent);
                                    }
                                } else if (document.getElementById(this.tagName).type != "") {
                                    document.getElementById(this.tagName).value = $(this).text();
                                } else {
                                    document.getElementById(this.tagName).innerHTML = $(this).text();
                                }

                            }
                            //if ($(this).attr('disabled') === 'disabled') {

                            //    $('#' + this.tagName).attr('disabled', true)
                            //}

                            if ($(this).attr('display') === 'show') {
                                if ($('[name=' + this.tagName + ']').data("type") === 'dateBox')
                                    $('[name=' + this.tagName + ']').parent().parent().show();
                                else
                                    $('[name=' + this.tagName + ']').parent().show();
                            }
                            else if ($(this).attr('display') === 'hide') {
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
                            //EndBy eLs updated by samuel 20180808
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
function checkChanges(t) {
    if (t) {
        var curdata = '';
        var olddata = $(this).data("old") == undefined ? "" : $(this).data("old");
        if (($("#" + t.id).prop("type") === "select-one") && (t.options[t.selectedIndex].value !== $("#" + t.id).data("value"))) {
            curdata = t.options[t.selectedIndex].value;
            //$("#" + t.id).data("value", t.options[t.selectedIndex].value);
        }
        else
            curdata = $(t).val();

        if (curdata !== olddata) {
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
                $('#button_save2').show();
                $('#button_cancel2').show();

            }
            form_edited = true;
        }


    }
}
function checkChanges_old(t) {
    if (t) {
        if (($("#" + t.id).prop("type") === "select-one") && (t.options[t.selectedIndex].value !== $("#" + t.id).data("value"))) {
            $("#" + t.id).data("value", t.options[t.selectedIndex].value);
        }
        $("input[type='text'], input[type='checkbox'], textarea, select").each(function () {
            var tx = $(this);
            //if ($(this).data("old") != undefined) {
            var old = $(this).data("old") == undefined ? "" : $(this).data("old");
            if (((tx.prop("type") === "text" || tx.prop("type") === "checkbox" || tx.prop("file"))
                && $(this).val() !== old && !tx[0].disabled && !$(tx).attr("readonly"))
                || tx.prop("type") === "select-one" && $(this).data("value") !== old) {
                if ($(this).data("child") === 'Y') {
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
                    $('#button_save2').show();
                    $('#button_cancel2').show();

                }
                form_edited = true;
            }
            //}
        });
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
    $('#button_save2').hide();
    $('#button_cancel2').hide();
}


function saveCancel() {
    if (getGUID() === "00000000-0000-0000-0000-000000000000") back();
    else {
        $("input[type='text'], input[type='checkbox'], textarea, select").each(function () {
            var t = $(this);
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

                        var sURL = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=' + tokenCode + '&key=' + key + '&id=' + id + '&name=' + name;
                        var cURL = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=' + tokenCode + '&key=' + key + '&id=' + id + '&name=' + name + '&search=' + search;
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

                                $('#button_save').hide();
                                $('#button_cancel').hide();
                                $('#button_submit').show();
                                $('#button_delete').show();
                                $('#button_approve').show();
                                $('#button_reject').show();
                                $('#button_save2').hide();
                                $('#button_cancel2').hide();
                                //$tokenInput(get, '');
                            }
                        });
                    }

                    $('#button_save').hide();
                    $('#button_cancel').hide();
                    $('#button_submit').show();
                    $('#button_delete').show();
                    $('#button_approve').show();
                    $('#button_reject').show();
                    $('#button_save2').hide();
                    $('#button_cancel2').hide();
                }
            } else {
                $('#button_save').hide();
                $('#button_cancel').hide();
                $('#button_submit').show();
                $('#button_delete').show();
                $('#button_approve').show();
                $('#button_reject').show();
                $('#button_save2').hide();
                $('#button_cancel2').hide();
            }
        });
        form_edited = false;
    }
}

function executeFunction(code, GUID, action, location, approvaluserguid, pwd, comment) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    if (approvaluserguid != undefined || approvaluserguid !== null) { pwd = document.getElementById("txtpwd" + approvaluserguid).value; }

    //add parameter approvaluserguid and pwd
    //location: browse:10, header form:20, header sidebar: 21, browse anak:30, browse form:40
    var successmsg = '', isAction = 1;
    var docState = getCookie(code.toLowerCase() + '_curstateid');

    if (action === 'execute') {
        if (docState === "" || docState === "0") {
            successmsg = 'Submited Succesfully';
            if (confirm("You are about to Submit this record. Are you sure?") == 0) { isAction = 0; }
        }
        else if (docState === '300') {
            successmsg = 'Re-Submited Succesfully';
            if (confirm("You are about to Re-Submit this record. Are you sure?") == 0) { isAction = 0; }
        }
        else {
            successmsg = 'Approve Succesfully';
            if (confirm("You are about to Approve this record. Are you sure?") == 0) { isAction = 0; }
        }
    } else if (action === 'force') {
        if (docState >= '400') {
            7;
            successmsg = 'Close/Archive Succesfully';
            if (confirm("You are about to Close/Archive this record. Are you sure?") == 0) { isAction = 0; }
        }
        else {
            successmsg = 'Rejected Succesfully';
            if (confirm("You are about to Reject this record. Are you sure?") == 0) { isAction = 0; }
        }
    } else if (action === 'reopen') {
        successmsg = 'Reopen Succesfully';
    } else if (action === 'inactivate') {
        successmsg = 'Inactivate Succesfully';
        if (confirm("You are about to " + action + " this record. Are you sure?") == 0) { isAction = 0; }
        action = "delete";
    } else if (action === 'delete') {
        successmsg = 'Delete Succesfully';
        if (confirm("You are about to " + action + " this record. Are you sure?") == 0) { isAction = 0; }
    } else if (action === 'restore') {
        successmsg = 'Restore Succesfully';
    } else if (action === 'wipe') {
        successmsg = 'Wipe Succesfully';
        if (confirm("You are about to " + action + " this record. Are you sure?") == 0) { isAction = 0; }
    }

    if (action === "delete" && location == 40) {
        if (isAction == 1) {
            preview(1, code, GUID, "form" + code, null);
        }
    }
    //add approvaluserguid and pwd and comment
    var path = 'OPHCore/api/default.aspx?code=' + code + '&mode=function&cfunction=' + action + '&cfunctionlist=' + GUID + '&comment=' + comment + '&approvaluserguid=' + approvaluserguid + '&pwd=' + pwd + unique;

    if (location == undefined || location === "") { location = 20; }
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, header sidebar: 21, browse anak:30, browse form:40



    if (isAction == 1) {
        $.post(path, function (data) {
            var msg = $(data).find('message').text();
            if (msg === '' || msg === 'Approval Succesfully' || msg.substring(0, 1) === '2') {
                //location: 0 header; 1 child; 2 browse 
                //location: browse:10, header form:20, browse anak:30, browse form:40
                //if ($("#tr1_" + code + GUID) && location !== '10' && action === "delete") {
                if (action === "delete" && (location == 30 || location == 40)) {
                    var g = GUID.split(",");
                    g.forEach(function (i) {
                        $("#tr1_" + code + i).remove();
                        $("#tr2_" + code + i).remove();
                    });
                }
                else {
                    if (action === 'delete' && location == 20) {
                        //location: 0 header; 1 child; 2 browse 
                        //location: browse:10, header form:20, header sidebar:21, browse anak:30, browse form:40

                        window.location = 'index.aspx?code=' + getQueryVariable("code");
                    }
                    //if (action === 'execute' && location == 21) {
                    //		//refresh sidebar
                    //                   loadContent(1);
                    //                   showMessage(successmsg);
                    //}
                    else {
                        //showMessage(successmsg);
                        loadContent(1);
                        showMessage(successmsg);
                    }

                    //window.location.reload();
                }
            }
            else {
                loadContent(1);
                showMessage(msg);
            }
        });
    }
}

function downloadModule(code, exportMode) {
    window.open('OPHCore/api/msg_rptDialog.aspx?gbox=1&code=' + code + '&mode=xls&exportMode=' + exportMode);
}

function downloadChild(code, t) {
    //var titleName = '';
    //var subtitleName = '';

    ParentGUID = $(t).parent().parent().parent().parent().parent().parent().parent().data("parentguid");
    if (ParentGUID == undefined) ParentGUID = getQueryVariable('GUID');
    
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
        if (input.value !== "NULL" && input.value != undefined) {
            if (sqlFilter === "") {
                sqlFilter = input.name + "='" + input.value + "'";
            } else {
                sqlFilter = sqlFilter + " and " + input.name + "='" + input.value + "'";
            }
        }
    });
    setCookie('sqlFilter', sqlFilter, 0, 0, 10);
    //loadContent(1)
    $.when($.ajax(loadContent(1))).done(function () { $(ini).button('reset'); });
}

function resetSQLFilter(ini) {
    var unique = getCookie("offline") == 1 ? '' : '&unique=' + getUnique();

    $(ini).button('loading');
    var divname = ['contentWrapper'];
    var xmldoc = 'OPHCore/api/default.aspx?mode=browse&code=' + getCode() + '&stateid=' + getState() + '&bSearchText=' + getSearchText() + unique;
    var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + '_' + getMode() + '.xslt'];
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
        var xsldoc = ['OPHContent/themes/' + loadThemeFolder() + '/xslt/' + getPage() + "_childBrowse.xslt"];
        pushTheme(divName, xmldoc, xsldoc, true);
    }
}
function form_init() {
    window.onbeforeunload = function (event) {
        if (form_added || form_changed) {
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


function genReport(code, outputType) {
    //if (parameter.indexOf(':') < 0) {
    //    var parvalue1 = "";
    //    var parameter = parameter.substring(0, (parameter.length - 1));
    //    do {
    //        if (parameter.indexOf(',') > -1) {
    //            parid = parameter.substring(0, parameter.indexOf(','));
    //            parid1 = parid

    //            do {
    //                parid1 = parid1.replace('*', '');
    //            }
    //            while (parid1.indexOf('*') > -1)
    //            if (parid1.substring(0, 1) == '#') {
    //                parid1 = parid1.replace("#", "");
    //                parid1 = parid1.replace("#", "");
    //                parvalue = parid1;
    //            }
    //            else {
    //                if (document.getElementById(parid1).type == 'checkbox') {
    //                    var r = document.getElementById(parid1).checked ? "True" : "False";
    //                    parvalue = "" + r + "";
    //                }
    //                else {
    //                    parvalue = document.getElementById(parid1).value;

    //                }
    //                parid = parid1.replace(parid1, parvalue);

    //            }

    //            if (outType == 1)
    //                parvalue1 += parid1 + ":''" + parvalue + "'',";
    //            else
    //                parvalue1 += parid1 + ":''" + parvalue + "'',";
    //            parameter = parameter.substring(parameter.indexOf(',') + 1, parameter.length);
    //        }
    //        else {
    //            if (parameter.length > 0) {
    //                do {
    //                    parameter = parameter.replace('*', '');
    //                }
    //                while (parameter.indexOf('*') > -1)
    //                if (parameter.substring(0, 1) == '#') {
    //                    parameter = parameter.replace("#", "");
    //                    parameter = parameter.replace("#", "");
    //                    parvalue1 += "''" + parameter + "''";
    //                }
    //                else {
    //                    if (eval("document.getElementById('" + parameter + "').type") == 'checkbox') {
    //                        var r = (eval("document.getElementById('" + parameter + "').checked")) ? "True" : "False";
    //                        if (outType == 1)
    //                            parvalue1 += parameter + ":" + r + "";
    //                        else
    //                            parvalue1 += parameter + ":" + r + "";
    //                    }
    //                    else {
    //                        if (outType == 1)
    //                            parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
    //                        else
    //                            parvalue1 += parameter + ":''" + eval("document.getElementById('" + parameter + "').value") + "''";
    //                    }
    //                }
    //                parameter = parvalue1;

    //            }
    //            break;
    //        }
    //    }
    //    while (parameter.indexOf(',') > -2)
    //}
    //parameter = parameter.replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null").replace("''''", "null");
    //var ParentGUID = '';
    //mode = (outType == 1) ? 'dplx' : 'gbox';
    //if (outputType == 'child') ParentGUID = '&parentGUID=' + getQueryVariable('GUID');
    url = 'OPHCore/api/msg_rptDialog.aspx?mode=' + outputType + '&code=' + code;

    urlsplit = url.split('?');
    urlonly = urlsplit[0];
    parform = urlsplit[1];
    par = parform.split('&');

    $('body').append($('<form/>')
        .attr({ 'action': urlonly, 'method': 'post', 'id': 'report', 'target': 'report' }));

    var thisForm = 'form';
    var dataFrm = $(thisForm).serialize();

    dataFrm.split('&').forEach(function (i) {
        d = i.split('=');
        var newVal = d[1];
        newVal = newVal.replace(/</g, '&lt;');
        newVal = newVal.replace(/>/g, '&gt;');
        //dataForm.append(d[0].toString(), d[1].toString());
        $('#report').append($('<input/>')
            .attr({ 'type': 'hidden', 'name': d[0].toString(), 'value': d[1].toString() })
        );
    });

    par.forEach(function (x) {
        $('#report').append($('<input/>')
            .attr({ 'type': 'hidden', 'name': x.split('=')[0], 'value': x.split('=')[1] })
        );
    });

    $('#report').submit();
    $('#report').remove();


    //window.open('OPHCore/api/msg_rptDialog.aspx?' + mode + '=1&code=' + code + '&parameter=' + parameter + '&outputType=' + outType + '&query=' + query + '&reportName=' + reportName);
    //window.open('OPHCore/api/msg_rptDialog.aspx?mode=' + outputType + '&code=' + code);
}

//radio
function panel_display(t, val, isdv) {
    //if (val == 1) {
    try {
        document.getElementById('accordion_' + t).style.display = 'block';
        //$('#' + t).val(val);
    } catch (e) { }
    //} else {
    //    try {
    //        document.getElementById('accordion_'+flag).style.display = 'none';
    //    } catch (e) { }
    //}
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
            $('#button_save2').show();
            $('#button_cancel2').show();
        }
    }
}