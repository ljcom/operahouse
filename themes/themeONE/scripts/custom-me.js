
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
                loadChild(code, pkfield, pkvalue, 1)
            }
        }

    })
}

function fillMobileItem(code, guid) {
    var tx1 = $('#mandatory' + guid).val();
    var tx2 = '<strong>'+tx1+'</strong> '+$('#summary' + guid).text();
    //var tx1='HR<br />RC';
    //var tx2='<b>RX16A002/RC16A004</b> 3 JAN 2016 POSITION: SALES MANAGER EXPECTED';
    var tx3 = '<b>WAIT FOR APPROVAL</b><br /><b>USER 3 </b>';
    var divname = 'collapse' + guid;

    var x = '<div class="panel box browse-phone">#d1##d2#</div>';
    x = x.replace('#d1#', '<div class="box-header with-border ellipsis">#h4#</div>');
    x = x.replace('#h4#', '<h4 class="box-title">#a#</h4>');
    x = x.replace('#a#', '<a data-toggle="collapse" data-parent="#accordion" href="#' + divname + '" style="color:black; text-transform: uppercase">#s##tx2#</a>');
    //x=x.replace('#s#','<span class="pull-left" style="margin-right:10px; color:#3C8DBC; font-weight:bold">#tx1#</span>');
    x = x.replace('#s#', '');
    //x=x.replace('#tx1#',tx1);
    x = x.replace('#tx2#', tx2);

    x = x.replace('#d2#', '<div id="' + divname + '" class="panel-collapse collapse">#d21#</div>');
    x = x.replace('#d21#', '<div class="box-body full-width-a">#d211##d212#</div>');
    x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3##a2#</div>');
    x = x.replace('#tx3#', tx3);
    x = x.replace('#a2#', '<a href="#" style="color:white; text-decoration:underline">see more</a><br /><br /><b>LAST COMMENT</b><br />WAIT FOR USER3<br /><br /><b>REQUESTED ON</b><br />ESRA MARTLIANTY (3 JAN 2016) <br /><a href="javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\')" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');
    x = x.replace('#ix#', '<ix class="fa fa-pencil"></ix>');

    x = x.replace('#d212#', '<div style="text-align:center; display:block; background:gray; padding:10px 0;">#t#</div>');
    x = x.replace('#t#', '<table style="width:100%">#tr#</table>');
    x = x.replace('#tr#', '<tr><td>&#160;</td>#td#<td>&#160;</td></tr>');

    bt = '<td width="1" style="padding:0 10px;">#a3#</td>#td#';
    bt = bt.replace('#a3#', '<a href="#">#bt#</a>');
    bt = bt.replace('#bt#', '<button type="button" class="btn btn-gray-a" style="background:#ccc; border:none;">#btname#</button>');

    var btname = 'REJECT';
    x = x.replace('#td#', bt.replace('#btname#', btname));

    var btname = 'APPROVE';
    x = x.replace('#td#', bt.replace('#btname#', btname));

    //close
    x = x.replace('#td#', '');

    $(x).appendTo("#accordion");
}