function LoadNewPart(filename, id, code, sqlfilter, searchText, bpageno, showpage, sortOrder) {


    if (bpageno == '' || bpageno == undefined) { bpageno = 1 }
    if (showpage == '' || showpage == undefined) { showpage = 21 }
    if (sortOrder == '' || sortOrder == undefined) { sortOrder = '' }
    var xsldoc = 'OPHContent/themes/themeSix/xslt/' + filename + '.xslt';
    var xmldoc = 'OPHCore/api/?mode=browse' + '&code=' + code + '&sqlfilter=' + sqlfilter + '&bSearchText=' + searchText + '&bpageno=' + bpageno + '&showpage=' + showpage + '&sortOrder=' + sortOrder + '&date=' + getUnique();

    showXML(id, xmldoc, xsldoc, true, true, function () {
        if (typeof f == "function") f();
    });
}

function saveThemeONE(code, guid, location, formId, afterSuccess, beforeStart) {
    //location: browse:10, header form:20, browse anak:30, browse form:40, save&add form anak: 41

    saveFunction(code, guid, location, formId, function (data) {
        var msg = $(data).children().find("message").text();
        var retguid = $(data).children().find("guid").text();

        if (location === 40 || location === 41) {
            //var pkfield = document.getElementById("PKSAVE" + code).value;
            var pkvalue = document.getElementById("PK" + code).value;
            var parentkey = document.getElementById("PKID").value.split('child').join('');
            var pkey = $('#parent' + code).val();
            var childKey = $('#childKey' + code).val();
        }

        //insert new form
        if (retguid != "" && retguid != guid && location === 20) window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + retguid;
        //insert child
        else if (retguid != "" && retguid != guid && location === 40) {
            //preview(1, code, guid, formId + code);
            if (msg != "") {
                showMessage(msg, 3);
            }
            loadChild(code, pkey, pkvalue)
            preview('1', getCode(), getGUID(), '', this);
        }
        else if (retguid !== "" && retguid !== guid && location === 41) {
            //preview(1, code, guid, formId + code);
            $.when(loadChild(code, pkey, pkvalue)).done(function () {
                $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                showChildForm(code, '00000000-0000-0000-0000-000000000000');
            });
        }
        else if (msg != "") {
            //compatible with load version

            if (isGuid(msg) && location == 20) {
                window.location = 'index.aspx?env=back&code=' + getCode() + '&guid=' + msg;
            }
            //compatible with load version
            else if (isGuid(msg) && location == 40) {
                preview(1, code, msg, formId + code);
                loadChild(code, pkey, pkvalue);
            }
            else if (isGuid(msg) && location == 41) {
                //preview(1, code, guid, formId + code);
                $.when(loadChild(code, pkey, pkvalue)).done(function () {
                    $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                    showChildForm(code, '00000000-0000-0000-0000-000000000000');
                });
            }
            else {
                showMessage(msg, 3);
            }
        }
        else {
            if (location == 20) {
                saveConfirm();
            } else {
                if (location == 41) {
                    $.when(loadChild(code, pkey, pkvalue)).done(function () {
                        $('#' + code + '00000000-0000-0000-0000-000000000000').hide();
                        showChildForm(code, '00000000-0000-0000-0000-000000000000');
                    });
                } else {
                    loadChild(code, pkey, pkvalue);
                    preview('1', getCode(), getGUID(), '', this);
                }
            }
            showMessage('Saving is successfully.', 2);
        }


        if (typeof afterSuccess === "function") afterSuccess(data);

    }, beforeStart)
}


function fillMobileItem(code, guid, Status, allowedit, allowDelete, allowWipe, allowForce, isDelegator) {
    var tx1 = $('#mandatory' + guid).val();
    var tx2 = '<strong>' + tx1 + '</strong> ' + $('#summary' + guid).text();
    var tx3 = '<b>WAIT FOR APPROVAL</b><br /><b>USER 3 </b>';
    var divname = 'collapse' + guid;

    if (isDelegator > 0) {
        var x = '<div class="panel box browse-phone">#d1#</div>';
    } else {
        isDelegator = 0;
        var x = '<div class="panel box browse-phone">#d1##d2#</div>';
    }

    x = x.replace('#d1#', '<div class="box-header with-border ellipsis">#h4#</div>');
    x = x.replace('#h4#', '<h4 class="box-title">#a#</h4>');
    x = x.replace('#a#', '<a data-toggle="collapse" data-parent="#accordionBrowse" href="#' + divname + '" style="color:black; text-transform: uppercase">#s##tx2#</a>');
    x = x.replace('#s#', '');
    x = x.replace('#tx2#', tx2);

    x = x.replace('#d2#', '<div id="' + divname + '" class="panel-collapse collapse">#d21#</div>');
    x = x.replace('#d21#', '<div class="box-body full-width-a">#d212#</div>');

    //x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3##a2#</div>');
    //x = x.replace('#d211#', '<div class="browse-status" style="background:gray; color:white; padding:10px; position:relative;">#tx3#<a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a></div>');
    //x = x.replace('#tx3#', tx3);
    //x = x.replace('#a2#', '<a href="#" style="color:white; text-decoration:underline">see more</a><br /><br /><b>LAST COMMENT</b><br />WAIT FOR USER3<br /><br /><b>REQUESTED ON</b><br />ESRA MARTLIANTY (3 JAN 2016) <br /><a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');

    //x = x.replace('#d211#', '<a href="#a4#" title="edit" style="position:absolute; top:10px; right:10px; font-size:17px; color:white;">#ix#</a>');

    x = x.replace('#d212#', '<div style="text-align:center; display:block; background:gray; padding:10px 0;">#t#</div>');
    x = x.replace('#t#', '<table style="width:100%">#tr#</table>');
    x = x.replace('#tr#', '<tr><td>&#160;</td>#td#<td>&#160;</td></tr>');

    bt = '<td width="1" style="padding:0 10px;">#bt#</td>#td#';
    bt = bt.replace('#bt#', '<button type="button" class="btn btn-gray-a" style="background:#ccc; border:none;" onclick="#abt#">#btname#</button>');

    var btname = "EDIT"
    if (allowedit == 1 && isDelegator == 0 ) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="fa fa-pencil"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'formView\', 1, 10)'));
    }

    var btname = 'DELETE';
    var btfn = 'inactivate';
    if (status < 500 && allowDelete == 1 && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="fa fa-trash"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'WIPE';
    var btfn = 'wipe';
    if (status == 999 && allowWipe == 1 && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="fa fa-trash"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'ARCHIEVE'; 
    var btfn = 'force';
    if (status < 500 && status >= 400 && allowForce == 1 && isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="fa fa-archive"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }

    var btname = 'APPROVE';
    var btfn = 'execute';
    if (isDelegator == 0) {
        x = x.replace('#td#', bt.replace('#btname#', '<ix class="fa fa-check"></ix> ' + btname).replace('#abt#', 'javascript:btn_function(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
    }
	
	var btname = 'REJECT';
	var btfn = 'force';
	if (isDelegator == 0 && status > 0 && status < 200) {
		x = x.replace('#td#', bt.replace('#btname#', '<ix class="far fa-check"></ix> ' + btname).replace('#abt#', 'javascript:rejectPopup(\'' + code + '\', \'' + guid + '\', \'' + btfn + '\', 1, 10)'));
	}

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
//setTimeout(function () { timeIsUp(); }, 1000 * 60 * 60);    //1 hour

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
        var msg = $(data).find('message').text();
        if (msg == '') {
            //alert("You have successfully change your password.");
            //location.reload();
            showMessage("You have successfully change your password", 2, undefined, function () {
                location.reload();
            });
        } else
            showMessage(msg);
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
        $('#' + divID).show();
    //document.getElementById(divID).style.display = "block";
    else
        $('#' + divID).hide();
        //document.getElementById(divID).style.display = "none";
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
        clickact = "deleteUserdele('" + childID + "', '" + idmodal + "', '" + guid + "')";
    } else if (action == "save") {
        clickact = "saveUserdele('" + formId + "', '" + childID + "', '" + idmodal + "', '" + guid + "')";
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

function select2editForm(ini) {
    var guid = $(ini).val();
    var id = $(ini).attr('id');
    var edit = '<span style= "cursor:pointer;float:right" data-toggle="modal" data-target="#addNew' + id + '" data-backdrop="static" ></span >'
    if (isGuid(guid)) {
        var divSpan = document.getElementById(id);
        $('#select2-' + id + '-container').append(edit);
        $('#select2-' + id + '-container').children().append('<ix class="fa fa-pencil" title= "Edit" ></ix >');
    }
}

function changeSkinColor() {
    if (getCookie('skinColor') != '')
        var bodyClass = getCookie('skinColor')
    else
        var bodyClass = 'skin-blue';
    $('body').addClass(bodyClass);
}

function loadExtraButton(buttons, divn, location) {
    //location: 10=browse, 11: browse-summary, 20: form (master), 21: form (tab)
    var cval;
    if (buttons) {
        if (location == 10) {
            $('td.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
					var cl = v.class;
                    var loc = v.location;
                    if (loc == undefined || loc.includes("10") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
                    var arurl = url.match(/%+\w+(?:%)/g);
                    if (arurl) {
                        arurl.forEach(function (val) {
                            val = val.split('%').join('');

                            if (val == 'guid') {
                                cval = $(td).parent().data(val);
                            }
                            else if (val == 'rid') {
                                cval = $(td).parent().data("guid");
                            }
                            else {
                                cval = $(td).parent().find("[data-field='" + val + "']").html();
								//find in content summary
								if (cval==null) cval = $(td).parent().next().find("[data-field='" + val + "']").html();
                            }

                            if (cval) {
                                url = url.split('%' + val + '%').join(cval);
                            }

                        });
                    }
                    //if (location==10 )
					uo = (v.updateOnly == 1) ? 1 : 0;
					uo = $(td).find("a:contains('"+v.caption+"')").length>0 ? 1 : uo;
					if (v.icon) uo = $(td).find('ix.'+v.icon.split(' ').join('.')).length>0 ? 1 : uo;
                    if (v.icon != null) {
                        a = "<a href=\"" + url + "\"><ix class='far " + v.icon + "' data-toggle=\"tooltip\" title='" + v.caption + "'/></a>";
					}
                    else {
                        a = "<a href=\"" + url + "\" title='" + v.caption + "'>" + v.caption + "</a>";
					}
                    //if (location==11 || location==20) a=' //button type="button" class="btn btn-danger btn-flat" onclick="javascript:submitTalk('{@GUID}', '10')">Send</button>'
                    
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
                            if (gstate == bstate[i]) {
                                if ($(td).find("a").find("." + v.icon).length > 0)
                                    $(td).find("a").find("." + v.icon).parent().attr("href", url);
                                else
                                    if (uo == 0) $(td).append(a);
                                return;
                            }
                        }
                    } else {
                        if ($(td).find("a").find("." + v.icon).length > 0)
                            $(td).find("a").find("." + v.icon).parent().attr("href", url);
                        else
                            if (uo == 0) $(td).append(a);
                    }
                });
            });
        }
        else if (location == 11) {
            $('div.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
                    var loc = v.location;
                    if (loc == undefined || loc.includes("11") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
                    var arurl = url.match(/%+\w+(?:%)/g);
                    if (arurl) {
                        arurl.forEach(function (val) {
                            val = val.split('%').join('');

                            if (val == 'guid') {
                                cval = $(td).parent().data(val);
                            }
                            else if (val == 'rid') {
                                cval = $(td).parent().data("guid");
                            }
                            else {
                                cval = $(td).parent().find("[data-field='" + val + "']").html();
                            }

                            if (cval) {
                                url = url.split('%' + val + '%').join(cval);
                            }

                        });
                    }
                    //if (v.icon != null)
                    a = '<button type="button" class="btn btn-orange-a ' + (location == 21 ? 'btn-block' : '') + ' btn-flat" onclick="' + url + '">' + v.caption + '</button>';
                    //else
                    //a = "<a href=\"" + url + "\">" + v.caption + "</a>";
                    uo = (v.updateOnly == 1) ? 1 : 0;
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
                            if (gstate == bstate[i]) {
                                if ($(td).find("a").find("." + v.icon).length > 0)
                                    $(td).find("a").find("." + v.icon).parent().attr("href", url);
                                else
                                    if (uo == 0) $(td).append(a);
                                return;
                            }
                        }
                    } else {
                        if ($(td).find("a").find("." + v.icon).length > 0)
                            $(td).find("a").find("." + v.icon).parent().attr("href", url);
                        else
                            if (uo == 0) $(td).append(a);
                    }
                });
            });
        }
        else if (location == 20) {
            $('div.' + divn).each(function (i, td) {
                var a, bstate;
                buttons.forEach(function (v) {
                    var url = v.url;
					var cl = v.class;
					if (cl==undefined) cl='btn-gray-a';
                    var loc = v.location;
                    var btnid = v.id;
                    if (loc == undefined || loc.includes("20") == false) {
                        return
                    }
                    //check variable
                    //check if loc=location, then run below
                    var arurl = url.match(/%+\w+(?:%)/g);
                    if (arurl != '' && arurl != null) {
                        arurl.forEach(function (val) {
                            val = val.split('%').join('');

                            if (val == 'guid') {
                                cval = $(td).parent().data(val);
                            }
                            else if (val == 'rid') {
                                cval = $(td).parent().data("guid");
                            }
                            else {
                                cval = $(td).parent().find("[data-field='" + val + "']").html();
                            }

                            if (cval) {
                                url = url.split('%' + val + '%').join(cval);
                            }

                        });
                    }
                    //if (v.icon != null)
                    //a = '<span  id="' + v.id + '" ><button type="button" style="width:100%" class="btn btn-orange-a ' + (location == 21 ? 'btn-block ' : '') + 'btn-flat" onclick="' + url + '">' + v.caption + '</button></span>';
                    a = '<button class="btn '+cl+' btn-block" onclick="' + url + '">' + v.caption + '</button>';
                    a = a.replace('%rid%', getGUID())
                    //else
                    //a = "<a href=\"" + url + "\">" + v.caption + "</a>";

                    uo = (v.updateOnly == 1) ? 1 : 0;
                    bstate = v.state;
                    if (bstate) {
                        bstate = bstate.split(' ').join('');
                        bstate = bstate.split(',');
                        for (var i = 0; i < bstate.length; i++) {
                            var gstate = (getState() == "" || getState() == undefined) ? "0" : getState();
                            if (gstate == bstate[i]) {
                                if ($(td).find("a").find("." + v.icon).length > 0)
                                    $(td).find("a").find("." + v.icon).parent().attr("href", url);
                                else
                                    if (uo == 0) $(td).append(a);
                                return;
                            }
                        }
                    } else {
                        if ($(td).find("a").find("." + v.icon).length > 0)
                            $(td).find("a").find("." + v.icon).parent().attr("href", url);
                        else
                            if (uo == 0) $(td).append(a);
                    }
                });
            });
        }
    }
}


function signInFrontEnd() {
    var uid = document.getElementById("userid").value;
    var pwd = document.getElementById("pwd").value;
    var cartID = ''//getCookie("cartID");
    var remember = ''//document.getElementById("rememberme");

    var dataForm = $('#signinForm').serialize() //.split('_').join('');

    var dfLength = dataForm.length;
    dataForm = dataForm.substring(2, dfLength);
    dataForm = dataForm.split('%3C').join('%26lt%3B');
    path = "OPHCore/api/default.aspx?mode=signin&userid=" + uid + "&pwd=" + pwd + "&cartID=" + cartID + '&withCaptcha=0'
//    LoadWave('show');
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
            var result = $(data).find("hostGUID").text();
            //            LoadWave('hide')
            if (result) {
                if (remember.checked == true) { setCookie("userID", uid, 30, 0, 0); }
                if (getQueryVariable("launch") != undefined && getQueryVariable("launch") != "") {
                    var landingPage = 'index.aspx?code=' + getQueryVariable("launch") + '&package=' + getQueryVariable("package") + '&plan=' + getQueryVariable("plan");
                } else {
                    var landingPage = (getCookie('lastPar') == null || getCookie('lastPar') == '') ? '?' : getCookie('lastPar');
                }
                window.location = landingPage;
            } else {
                //alert('Invalid User or password!');
                document.getElementById("notiContent").innerHTML = 'Invalid User ID or password!';
                $("#notiTitle").html('Warning!');
                $('#notiModal').modal()
            }
        }
    });
}

function batchUpload(code, guid, location, formId, eid, dataFrm, afterSuccess) {
    saveBatchUpload(code, guid, location, formId, eid, dataFrm, afterSuccess);
}

function saveBatchUpload(code, guid, location, formId, eid, dataFrm, afterSuccess) {
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


            if ($(':file').length > 0) {
                $(":file").each(function (i) {

                    $.each($(':file')[i].files, function (key, value) {
                        var textfile = $('#' + eid + $(':file')[i].name.replace('_hidden', ''))
                        var length = $(':file')[i].files.length
                        var data = new FormData();
                        var thisForm = 'form';
                        thisForm = '#' + formId;
			var fileNameX = value.name
                        var msgX = ''
                        if (fileNameX.indexOf('.jpg') > -1 || fileNameX.indexOf('.png') > -1 || fileNameX.indexOf('.gif') > -1  
                            || fileNameX.indexOf('.xlsx') > -1 || fileNameX.indexOf('.xls') > -1
                            || fileNameX.indexOf('.pdf') > -1 || fileNameX.indexOf('.docx') > -1 || fileNameX.indexOf('.doc') > -1
                            || fileNameX.indexOf('.pptx') > -1 || fileNameX.indexOf('.txt') > -1
                            ) 
                        {
                        //    msgX = 'success'
                        //}
                        data.append(key, value);
                        textfile.val(value.name);

                        var other_data = $(thisForm).serializeArray();

                        $.each(other_data, function (key, input) {
                            var newVal = input.value;
                            newVal = newVal.replace(/</g, '&lt;');
                            newVal = newVal.replace(/>/g, '&gt;');
                            data.append(input.name, newVal);
                        });

                        //                    data.append('parentdocguid', getGUID());


                        //alert(value.name);

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
                            if (length != 0 && length != '' && length == key + 1) {
                               var msg = $(data).find('messages').text();
                                    if (code.toLowerCase() == 'toinvcdetl' || code.toLowerCase() == 'toincsdetl') {
                                        if (msg) {
				    	    loadChild(code.toLowerCase(), 'parentdocguid', GUID, null, 'custominline_invoice');
                                            showMessage(msg);
                                        } else {
                                            loadChild(code.toLowerCase(), 'parentdocguid', GUID, null, 'custominline_invoice');
                                        }
                                       
                                    } else window.location.reload();
  
                            }
                        });
			 } else {
                            if (length != 0 && length != '' && length == key + 1) {
                                if (code.toLowerCase() == 'toinvcdetl' || code.toLowerCase() == 'toincsdetl') {
                                    
                                    loadChild(code.toLowerCase(), 'parentdocguid', GUID, null, 'custominline_invoice');
				    showMessage("You can only upload file with this extension file (.jpg, .png, .gif, .xlsx, .xls, .pdf, .doc, .docx, .pptx, .txt)");
                                } else window.location.reload();
                            }
                        }
                    });
                });
            }
           
        }
    }

}


function showMessage(msg, mode, fokus, afterClosed, afterClick) {
    var msgType;
    if (mode==0 || mode == undefined) mode = 1;
    if (msg) {
        if (mode == 1) msgType = 'info';
        else if (mode == 2) msgType = 'success';
        else if (mode == 3) msgType = 'warning';
        else if (mode == 4) msgType = 'error';
        else if (mode == 10) msgType = 'confirm';

        if (msg === '' && (mode == 4 || mode == 3)) msg = 'Time out.';

        $("#notiTitle").text(msgType);
        $("#notiContent").text(msg);
        if (mode < 10) {
            //$('#modal-btn-close').show();
            //$('#modal-btn-cancel').hide();
            //$('#modal-btn-confirm').hide();
            //toastr[msgType](msgType, msg)
        }
        else {
            //$('#modal-btn-close').hide();
            //$('#modal-btn-cancel').show();
            //$('#modal-btn-confirm').attr('onclick', function () {
            //    afterClick();
            //}).show();

        }

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        toastr[msgType](msgType, msg);

        //$("#notiModal").modal();

        if (typeof afterClosed === "function") {
            $("#notiModal").on("hidden.bs.modal", function (e) {
                $("#notiModal").on("hidden.bs.modal", null);
                afterClosed();

            });
        }

        if (fokus || afterClosed) {
            try {
                document.getElementById('notiBtn').onclick = function () {
                    if (fokus) $(fokus).focus();
                    //if (typeof afterClosed === "function") afterClosed();
                };
            }
            catch (e) {
                //
            }
        }
    }
}

function replaceContent() {
    var str = $('#content-post1').html();

    var res = str
    res = res.replace(/&lt;/g, "<");
    res = res.replace(/&gt;/g, ">");

    res = res.replace(/&amp;lt;/g, "<");
    res = res.replace(/&amp;gt;/g, ">");
    $('#content-post1').html(res);

}


function rejectPopup(code, GUID, action, page, location, formId, afterSuccess) {
    $("#rejectModal").modal('show');
    $("#rejectModal").appendTo('body');
    
        //$("#nModal").modal('show');
        document.getElementById('rejectComment').onkeyup = function () {
            $('#rejectBtn').css('visibility', $('#rejectComment').val() !== '' ? 'visible' : 'hidden');
        };
    
        document.getElementById('rejectBtn').onclick = function () {
            var comment = $('#rejectComment').val();
            btn_function(code, GUID, action, page, location, formId, comment, afterSuccess);
        };
        
}

function signUpUser(account) {
	r=false;
	if ($('#username').val()=='' || $('#emailadd').val()=='' || $('#newpwd').val()=='' || $('#confirmpwd').val()=='') {
		showMessage('Please complete all fields before continue.');
	}
	else if($('#emailadd').val().split(' ').length>1) {
		showMessage('Email Address cannot using space.');
		
	}
	else { 						
		// showMessage("Thank you for sign upPlease check your email to get User ID and Password to Access");
		var username = $('#username').val();
		var emailadd = $('#emailadd').val();
		var newpwd = $('#newpwd').val();
		var confirmpwd = $('#confirmpwd').val();

		//var uid = getCookie(account + '_userId');
		//if ($("#userid").val() !== "") uid = $("#userid").val();
		// var pwd = $("#pwd").val();

		var dataForm = new FormData();

		dataForm.append('mode', 'signup');
		dataForm.append('username', username);
		dataForm.append('emailaddress', emailadd);
		dataForm.append('newpwd', newpwd);
		dataForm.append('confirmpwd', confirmpwd);
		//dataForm.append('newpwd', $('#newpwd').val());
		//dataForm.append('confirmpwd', $('#confirmpwd').val());
		r=true;
		path = "OPHCore/api/default.aspx";
		$.ajax({
			url: path,
			data: dataForm,
			type: 'POST',
			cache: false,
			contentType: false,
			processData: false,
			dataType: "xml",
			timeout: 80000,
			beforeSend: function () {
				//setCursorWait(this);
			},
			success: function (data) {
				// showMessage("Thank you for sign upPlease check your email to get User ID and Password to Access");
				var x = $(data).find("sqroot").children().each(function () {
					var msg = $(this).text();

					if (msg !== '') {
						if ($(this)[0].nodeName === "message") {
							showMessage(msg);
						}
					}
					// else{
						// showMessage("Thank you for sign upPlease check your email to get User ID and Password to Access");
					// }
				});
			}
		});
	}
	return r;
}

function login_sendmail(username,email,pwd,guid) {

	var comments = '&lt;sqlstr&gt;&lt;login&gt;&lt;name&gt;'+username+'&lt;/name&gt;&lt;email&gt;'+email+'&lt;/email&gt;&lt;pwd&gt;'+pwd+'&lt;/pwd&gt;&lt;/login&gt;&lt;/sqlstr&gt;';
	
	executeFunction("login", guid, "sendmail", null, null, null, comments,
	 function(data){
	  var guidX = $(data).find('guid').text();
	  
	 
	 } )
	 
};