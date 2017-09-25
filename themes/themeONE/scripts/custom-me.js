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
    //location: browse:10, header form:20, browse anak:30, browse form:40

    saveFunction(code, guid, location, formId, function (data) {
        var msg = $(data).children().find("message").text();
        var retguid = $(data).children().find("guid").text();
        //if (retguid == "" && isGuid(msg)) {
        //    retguid = msg;
        //}
        //location: browse:10, header form:20, browse anak:30, browse form:40
        if (location == 40) {
            //var pkfield = document.getElementById("PKSAVE" + code).value;
            var pkvalue = document.getElementById("PK" + code).value;
            var parentkey = document.getElementById("PKID").value.split('child').join('');
            var pkey = $('#parent' + code).val();
            var childKey = $('#childKey' + code).val()
        }
        //insert new form
        if (retguid != "" && retguid != guid && location == 20) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
            //insert child
        else if (retguid != "" && retguid != guid && location == 40) {
            //xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkey + "='" + pkvalue + "'";
            preview(1, code, guid, formId + code);
            //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
            loadChild(code, pkey, pkvalue, 1)

        }
        else if (msg != "") {
            //compatible with load version

            if (isGuid(msg) && location == 20) {
                window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + msg;
            }
                //compatible with load version
            else if (isGuid(msg) && location == 40) {
                //xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkey + "='" + pkvalue + "'";
                preview(1, code, msg, formId + code);
                //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
                loadChild(code, pkey, pkvalue, 1)
            }
            else {
                showMessage(msg);
            }
        }
        else {
            if (location == 20) {
                //location.reload();
                saveConfirm();
            } else {
                //xmldoc = "OPHCORE/api/default.aspx?code=" + code + "&mode=browse&sqlFilter=" + pkfield + "='" + pkvalue + "'";
                //showXML(pkid, xmldoc, xsldoc + "_childBrowse.xslt", true, true, function () { });
                loadChild(code, pkey, pkvalue, 1)
            }
        }

    })
}

function fillMobileItem(code, guid, Status, allowedit, allowDelete, allowWipe, allowForce) {
    var tx1 = $('#mandatory' + guid).val();
    var tx2 = '<strong>' + tx1 + '</strong> ' + $('#summary' + guid).text();
    //var tx1='HR<br />RC';
    //var tx2='<b>RX16A002/RC16A004</b> 3 JAN 2016 POSITION: SALES MANAGER EXPECTED';
    var tx3 = '<b>WAIT FOR APPROVAL</b><br /><b>USER 3 </b>';
    var divname = 'collapse' + guid;

    var x = '<div class="panel box browse-phone">#d1##d2#</div>';
    x = x.replace('#d1#', '<div class="box-header with-border ellipsis">#h4#</div>');
    x = x.replace('#h4#', '<h4 class="box-title">#a#</h4>');
    x = x.replace('#a#', '<a data-toggle="collapse" data-parent="#accordionBrowse" href="#' + divname + '" style="color:black; text-transform: uppercase">#s##tx2#</a>');
    //x=x.replace('#s#','<span class="pull-left" style="margin-right:10px; color:#3C8DBC; font-weight:bold">#tx1#</span>');
    x = x.replace('#s#', '');
    //x=x.replace('#tx1#',tx1);
    x = x.replace('#tx2#', tx2);

    x = x.replace('#d2#', '<div id="' + divname + '" class="panel-collapse collapse">#d21#</div>');
    x = x.replace('#d21#', '<div class="box-body full-width-a">#d211##d212#</div>');
    x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3##a2#</div>');
    x = x.replace('#tx3#', tx3);
    x = x.replace('#a2#', '<a href="#" style="color:white; text-decoration:underline">see more</a><br /><br /><b>LAST COMMENT</b><br />WAIT FOR USER3<br /><br /><b>REQUESTED ON</b><br />ESRA MARTLIANTY (3 JAN 2016) <br /><a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');
    if (allowedit == 1) {
        x = x.replace('#ix#', '<ix class="fa fa-pencil"></ix>');
        x = x.replace('#a4#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)');
    }
    else {
        x = x.replace('#ix#', '<ix class="fa fa-pencil" style="color:LightGray"></ix>');
        x = x.replace('#a4#', '#');
    }
    x = x.replace('#d212#', '<div style="text-align:center; display:block; background:gray; padding:10px 0;">#t#</div>');
    x = x.replace('#t#', '<table style="width:100%">#tr#</table>');
    x = x.replace('#tr#', '<tr><td>&#160;</td>#td#<td>&#160;</td></tr>');

    bt = '<td width="1" style="padding:0 10px;">#a3#</td>#td#';
    bt = bt.replace('#a3#', '<a href="#">#bt#</a>');
    bt = bt.replace('#bt#', '<button type="button" class="btn btn-gray-a" style="background:#ccc; border:none;">#btname#</button>');

    var btname = 'DELETE';
    if (status < 500 && allowDelete == 1) x = x.replace('#td#', bt.replace('#btname#', btname));

    var btname = 'WIPE';
    if (status == 999 && allowWipe == 1) x = x.replace('#td#', bt.replace('#btname#', btname));

    var btname = 'ARCHIEVE';
    if (status < 500 && status >= 400 && allowForce == 1) x = x.replace('#td#', bt.replace('#btname#', btname));

    var btname = 'APPROVE';
    x = x.replace('#td#', bt.replace('#btname#', btname));

    //close
    x = x.replace('#td#', '');

    $(x).appendTo("#accordionBrowse");
}

function addpagenumber(pageid, currentpage, totalpages) {
    cp = parseInt(currentpage);
    tp = parseInt(totalpages);
    var result = "";
    if (tp > 1) {
        if (cp != 1) result += "<li><a href='javascript:loadContent(" + (cp - 1) + ")'>&#171;</a></li>";

        var before = "";
        var after = "";

        if (cp - 2 > 0)
            result += "<li><a href='javascript:loadContent(" + (cp - 2) + ")'>" + (cp - 2) + "</a></li>";

        if (cp - 1 > 0)
            result += "<li><a href='javascript:loadContent(" + (cp - 1) + ")'>" + (cp - 1) + "</a></li>";

        result += "<li><a style ='background-color:#3c8dbc;color:white;'href='javascript:loadContent(" + cp + ")'>" + cp + "</a></li>";

        if (cp + 1 <= tp)
            result += "<li><a href='javascript:loadContent(" + (cp + 1) + ")'>" + (cp + 1) + "</a></li>";
        if (cp + 2 <= tp)
            result += "<li><a href='javascript:loadContent(" + (cp + 2) + ")'>" + (cp + 2) + "</a></li>";

        if (cp != tp) result += "<li><a href='javascript:loadContent(" + (cp + 1) + ")'>&#187;</a></li>";

        result += "<li>&nbsp;&nbsp;&nbsp;</li>"


        var combo = "<li><select style ='background:#fafafa;color:#666;border:1px solid #ddd;height:30px;'onchange='loadContent(this.value)'>";
        for (var i = 1 ; i <= parseInt(tp) ; i++) {
            combo += "<option value =" + i + " " + (cp == i ? "selected" : "") + ">" + i + "</option>";
        };

        combo += '</select></li>';

        result += combo;


        $('#' + pageid).html(result);
    }
}

function timeIsUp() {
    //lastPar = window.location;
    //setCookie('lastPar', lastPar);
    //setCookie("userId", "", 0, 0, 0);
    window.location = 'index.aspx?env=acct&code=lockscreen';
}
setTimeout(function () { timeIsUp(); }, 1000 * 60 * 60);

function isGuid(stringToTest) {
    if (stringToTest[0] === "{") {
        stringToTest = stringToTest.substring(1, stringToTest.length - 1);
    }
    var regexGuid = /^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$/gi;
    return regexGuid.test(stringToTest);
}

function checkPassProfile(id) {
    var pass = (document.getElementById(id).value == undefined) ? "" : document.getElementById(id).value;

    if (pass != "") {
        var msg = "";
        if (pass.length < 6) {
            msg = "Minimum Password Requirement is 6 Characters!";
            document.getElementById("e" + id).style.display = "block";
            document.getElementById("e" + id).innerHTML = msg;

            document.getElementById("btn_pass").disabled = true;
        } else {
            if (id == "conPass") {
                var conPass = document.getElementById("newPass").value;
                msg = (pass == conPass) ? "" : "Password does not matches!";

                if (msg != "") {
                    document.getElementById("e" + id).style.display = "block";
                    document.getElementById("e" + id).innerHTML = msg;

                    document.getElementById("enewPass").style.display = "block";
                    document.getElementById("enewPass").innerHTML = msg;

                    document.getElementById("btn_pass").disabled = true;
                } else {
                    document.getElementById('e' + id).style.display = 'none';
                    document.getElementById('enewPass').style.display = 'none';
                }
            } else {
                document.getElementById('e' + id).style.display = 'none';
            }
        }
    } else if (id == "conPass" && document.getElementById("newPass").value != "" && pass == "") {
        msg = "You have to fill this!";
        document.getElementById("e" + id).style.display = "block";
        document.getElementById("e" + id).innerHTML = msg;
        document.getElementById("btn_pass").disabled = true;
    }
    else {
        document.getElementById('e' + id).style.display = 'none';
    }

    if (msg == "") {
        var curPass = document.getElementById('curPass').value;
        var newPass = document.getElementById('newPass').value;
        var conPass = document.getElementById('conPass').value;

        if (curPass != "" && newPass != "" && conPass != "") {
            document.getElementById("btn_pass").disabled = false;
        }
    }
}

function profileOnChange(id) {
    oldValue = $('#' + id).data('old');
    newValue = $('#' + id).val();

    if (oldValue != newValue) {
        $('#save_profile').removeAttr('disabled');
    } else {
        $('#save_profile').attr('disabled', 'disabled');
    }
}

function changePassProfile() {
    var curPass = document.getElementById('curPass').value;
    var newPass = document.getElementById('newPass').value;

    var urlPath = "OPHCore/api/default.aspx?code=profile&mode=changePassword&curpass=" + curPass + "&newpass=" + newPass + "&unique=" + getUnique();

    $.post(urlPath, function (data) {
        var msg = $(data).find('messages').text();
        if (msg == '') {
            alert("You have successfully change your password.");
            location.reload();
        } else {
            alert(msg);
        }
    });
}

function saveProfile(formId, code, guid) {
    $('#save_profile').button('loading');
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

    $.ajax({
        type: "POST",
        url: "OPHCore/api/default.aspx?code=" + code + "&mode=saveProfile&cfunctionlist=" + guid + "&",
        enctype: 'multipart/form-data',
        cache: false,
        contentType: false,
        processData: false,
        data: data,
        success: function () {
        }
    }).done(function (data) {
        var msg = $(data).find('messages').text();
        var mdl = $('#allModal');
        $('#modal-btn-close').show();
        $('#modal-btn-cancel').hide();
        $('#modal-btn-confirm').hide();
        if (msg == '') {
            mdl.find('.modal-title').text("Success!");
            mdl.find('.modal-body').text("Profile was updating successfully !");
            $('#save_profile').text($('#save_profile').data('text'));
            $('#save_profile').removeClass().addClass('btn btn-success');
        } else {
            mdl.find('.modal-title').text("Failure!");
            mdl.find('.modal-body').text(msg);  
            $('#save_profile').button('reset');
        }
        mdl.modal('show');
    });
}

function showUploadBox(divID, act) {
    if (act == 1)
        document.getElementById(divID).style.display = "block";
    else
        document.getElementById(divID).style.display = "none";
}

function uploadBox(id, formId, code, guid) {

    //browse a file
    $('#' + id + "_file").click();

    // We can attach the `fileselect` event to all file inputs on the page
    $(document).on('change', ':file', function () {
        var input = $('#' + id + "_file"),
            numFiles = input.get(0).files ? input.get(0).files.length : 1,
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.trigger('fileselect', [numFiles, label]);

        var file = this.files[0];
        if (file.size > 1000000) {
            alert('Maximum file size is 1 Mb')
        }
    });

    // We can watch for our custom `fileselect` event like this
    $(document).ready(function () {
        $(':file').on('fileselect', function (event, numFiles, label) {

            var input = $('#' + id + "_file").parents('.input-group').find(':text'),
                //log = numFiles > 1 ? numFiles + ' files selected' : label;
                log = label;
            if (input.length) {
                input.val(log);
            } else {
                //if( log ) alert(log);
                if (log) {
                    document.getElementById(id).value = log;
                    saveProfile(formId, code, guid);
                } 
            }
        });
    });

}

function showModal(ini, action, formId, childID, guid) {
    var idmodal = $(ini).data('target'); 
    idmodal = (idmodal.indexOf('#') < 0) ? "#" + idmodal : idmodal;
    var title = $(ini).data('caption');
    var msg = $(ini).data('msg');
    var md = $(idmodal);
    md.find('.modal-title').text(title);
    md.find('.modal-body').text(msg);
    var clickact = ""
    if (action == "delete") {
        clickact = "deleteUserdele('" + childID + "', '" + idmodal + "', '" + guid +"')";
    } else if (action == "save") {
        clickact = "saveUserdele('" + formId + "', '" + childID + "', '" + idmodal + "', '" + guid +"')";
    }
    $('#modal-btn-close').hide();
    $('#modal-btn-cancel').show();
    $('#modal-btn-confirm').attr('onclick', clickact).show();
    md.modal({ backdrop: "static" });
}

function tokenizer(name, tokenID) {
    var url = 'OPHCore/api/msg_autosuggest.aspx?mode=token&code=userdele&colkey=' + name
    $("#" + name + tokenID).tokenInput(url, {
        hintText: "please type...", searchingText: "Searching...", preventDuplicates: true, allowCustomEntry: false, highlightDuplicates: false,
        tokenDelimiter: "*", theme: "facebook", prePopulate: "", onAdd: function (x) { checkToken(name + tokenID); }, onDelete: function (x) { checkToken(name + tokenID); }
    });
}

function addNewDele(ini) {
    var leChild = document.getElementById("deleparent").lastElementChild;
    var leChildID = leChild.id.split("delechild").pop();
    var newID = parseInt(leChildID) + 1;
    var divParent = document.getElementById("deleparent");
    var divChild = document.getElementById("delechild0");
    var addChild = document.importNode(divChild, true)
    addChild.innerHTML = addChild.innerHTML.split("delechild0").join("delechild" + newID);
    addChild.innerHTML = addChild.innerHTML.split("formDelegate0").join("formDelegate" + newID);
    addChild.innerHTML = addChild.innerHTML.split("guid0").join("guid" + newID);
    addChild.innerHTML = addChild.innerHTML.split("GUID0").join("GUID" + newID);
    addChild.innerHTML = addChild.innerHTML.split("TokenDelegate0").join("TokenDelegate" + newID);
    addChild.innerHTML = addChild.innerHTML.split("TokenModule0").join("TokenModule" + newID);
    addChild.innerHTML = addChild.innerHTML.split("btn-del0").join("btn-del" + newID);
    addChild.innerHTML = addChild.innerHTML.split("btn-save0").join("btn-save" + newID);
    addChild.id = "delechild" + newID;
    addChild.removeAttribute("style");
    addChild.setAttribute("data-new", "true");
    divParent.appendChild(addChild);
    $("#addele").attr("disabled", "disabled");
    tokenizer("TokenDelegate", newID);
    tokenizer("TokenModule", newID);
}

function checkToken(idToken) {
    var oldValue = $('#' + idToken).data('old-value');
    var newValue = $('#' + idToken).val();
    var indID = "", otherValue = "";

    //attention!! This "indexOf" is case-sensitive
    if (idToken.indexOf('TokenDelegate') >= 0) {
        indID = idToken.split('TokenDelegate').pop();
        otherValue = $('#TokenModule' + indID).val();
    } else {
        indID = idToken.split('TokenModule').pop();
        otherValue = $('#TokenDelegate' + indID).val();
    }

    if (newValue != "") {
        if (newValue != oldValue && otherValue != "") {
            $('#btn-save' + indID).removeAttr('disabled');
        } else if (newValue != oldValue && otherValue == "") {
            $('#btn-save' + indID).attr('disabled', 'disabled');
        }
    } else {
        $('#btn-save' + indID).attr('disabled', 'disabled');
    }
}

function deleteUserdele(childID, modalID, guid) { 

    var isNew = $('#' + childID).data('new');

    if (isNew != undefined) {
        //removing child
        var item = document.getElementById(childID);
        item.parentNode.removeChild(item);

        var leChild = document.getElementById("deleparent").lastElementChild;
        var maxID = leChild.id.split("delechild").pop();
        var isContinue = true;
        for (var i = 1; i < maxID; i++) {
            if ($("#btn-save" + i).attr("disabled") == undefined) {
                isContinue = false;
                break;
            }
        }
        var dataNew = $('#' + leChild.id).data('new');
        if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
        $(modalID).modal('hide');
    } else {
        var url = "OPHCore/api/default.aspx?code=userdele&mode=function&cfunction=delete&cfunctionlist=" + guid + '&comment&unique=' + getUnique();
        var deleting = $.post(url);
        $('#modal-btn-confirm').button('loading');
        $('#modal-btn-cancel').hide();
        deleting.done(function (data) {
            var msg = $(data).find('message').text();
            var mdl = $(modalID);

            if (msg == "" || msg == undefined || isGuid(msg) == true) {
                mdl.find('.modal-title').text("Success!");
                mdl.find('.modal-body').text("Entry was deleting successfully !");
                $('#modal-btn-close').show();
                $('#modal-btn-cancel').hide();
                $('#modal-btn-confirm').hide();

                //removing child
                var item = document.getElementById(childID);
                item.parentNode.removeChild(item);

                var leChild = document.getElementById("deleparent").lastElementChild;
                var maxID = leChild.id.split("delechild").pop();
                var isContinue = true;
                for (var i = 1; i < maxID; i++) {
                    if ($("#btn-save" + i).attr("disabled") == undefined) {
                        isContinue = false;
                        break;
                    }
                }
                var dataNew = $('#' + leChild.id).data('new');
                if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
                $('#modal-btn-confirm').button('reset');
            } else {
                md.find('.modal-title').text("Error!");
                md.find('.modal-body').text(msg);
                $('#modal-btn-close').show();
                $('#modal-btn-cancel').hide();
                $('#modal-btn-confirm').hide();
                $('#modal-btn-confirm').button('reset');
            }
        });
    }
}

function saveUserdele(formId, childID, modalID, guid) {
    $('#modal-btn-confirm').button('loading');
    $('#modal-btn-cancel').hide();

    var popID = childID.split("delechild").pop();
    var other_data = $('#' + formId).serializeArray();

    var data = new FormData();
    $.each(other_data, function (key, input) {
        data.append(input.name.split(popID).join(""), input.value);
    });

    var savePost = $.post({
        url: "OPHCore/api/default.aspx?code=userdele&mode=save&cfunctionlist=" + guid,
        enctype: 'multipart/form-data',
        cache: false,
        contentType: false,
        processData: false,
        data: data
    });
    savePost.done(function (data) {
        var msg = $(data).find('message').text();
        var mdl = $(modalID);

        if (msg == "" || msg == undefined || isGuid(msg) == true) {
            mdl.find('.modal-title').text("Success!");
            mdl.find('.modal-body').text("Entry was saving successfully !");
            $('#modal-btn-close').show();
            $('#modal-btn-cancel').hide();
            $('#modal-btn-confirm').hide();

            $('#btn-save' + popID).attr("disabled", "disabled");
            $('#' + childID).removeAttr("data-new");
            $('#' + childID).removeData("new");

            var leChild = document.getElementById("deleparent").lastElementChild;
            var maxID = leChild.id.split("delechild").pop(); 
            var isContinue = true;
            for (var i = 1; i < maxID; i++) {
                if ($("#btn-save" + i).attr("disabled") == undefined) {
                    isContinue = false;
                    break;
                }
            }
            var dataNew = $('#' + leChild.id).data('new');
            if (isContinue == true && dataNew == undefined) $('#addele').removeAttr('disabled');
            $('#modal-btn-confirm').button('reset');
        } else {
            md.find('.modal-title').text("Error!");
            md.find('.modal-body').text(msg);
            $('#modal-btn-close').show();
            $('#modal-btn-cancel').hide();
            $('#modal-btn-confirm').hide();
            $('#modal-btn-confirm').button('reset');
        }
    });
}

