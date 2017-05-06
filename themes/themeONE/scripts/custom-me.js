
function LoadNewPart(filename, id, code, sqlfilter, searchText, bpageno, showpage, sortOrder) {
    if (filename == 'product') {
        filename = filename + '_' + getCookie('browsetype');
        bpageno = getCookie("bpageno");
        sortOrder = getCookie("sortOrder");
        showpage = getCookie("showpage");
    }

    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    var xsldoc = 'OPHContent/themes/themeTwo/xslt/' + filename + '.xslt';
    var xmldoc = 'OPHCore/api/?mode=browse' + '&code=' + code + '&sqlfilter=' + sqlfilter + '&bSearchText=' + searchText + '&bpageno=' + bpageno + '&showpage=' + showpage + '&sortOrder=' + sortOrder + '&date=' + getUnique();

    showXML(id, xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });
}
function saveThemeONE(code, guid, location, formId) {

    saveFunction(code, guid, location, formId, function (data) {
        var msg = $(data).children().find("message").text();
        var retguid = $(data).children().find("guid").text();
        //if (retguid == "" && isGuid(msg)) {
        //    retguid = msg;
        //}
        if (location == 1) {
            var pkfield = document.getElementById("PKSAVE" + code).value;
            var pkvalue = document.getElementById("PK" + code).value;
            var parentkey = document.getElementById("PKID").value.split('child').join('');
        }
        if (retguid != "" && retguid != guid && location == 0) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
        else if (retguid != "" && retguid != guid && location == 1) {
            xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
            preview(1, code, guid, formId + code);
            //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
            loadChild(code, pkfield, pkvalue, 1)

        }
        else if (msg != "") {
            //compatible with load version
            if (isGuid(msg) && location == 0) {
                window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + msg;
            }
                //compatible with load version
            else if (isGuid(msg) && location == 1) {
                xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
                preview(1, code, msg, formId + code);
                //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
                loadChild(code, pkfield, pkvalue, 1)
            }
            else {
                showMessage(msg);
            }
        }
        else {
            if (location == 0) {
                //location.reload();
                saveConfirm();
            } else {
                xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
                //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
                loadChild(code, parentkey, pkvalue, 1)
            }
        }

    })
}