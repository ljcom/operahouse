
//DOCUMENT TALK FUNCTIONS v3

function enterTalk(guid, e, location) {
    if (e.keyCode == 13) {
        submitTalk(guid, location)
    }
}

function submitTalk(guid, location) {
    var comment = $('#message').val();
    if (guid == '') guid = $('#cid').val();
    //location: 0 header; 1 child; 2 browse 
    //location: browse:10, header form:20, browse anak:30, browse form:40
    var commentBrowse = $('#message' + guid).val();
    if (comment) {
        refreshTalk(guid, comment, location, function () {
            $('#message').val('');
            $('#message').focus();
        });
    }
    else {
        if (commentBrowse) {
            refreshTalk(guid, commentBrowse, location, function () {
                $('#message' + guid).val('');
                $('#message' + guid).focus();
            });
        }
        else {
            showMessage('Please put your comment before press enter');
        }
    }
}

function refreshTalk(guid, comment, location, f) {
    divname = 'chatMessages';
    var xmldoc = 'OPHCore/api/default.aspx?mode=talk&guid=' + guid + "&comment=" + comment + "";
    var xsldoc
    if (location == '10') {
        divname = divname + guid;
        xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_browse_talk.xslt';
    }
    else {
        xsldoc = 'OPHContent/themes/' + loadThemeFolder() + '/xslt/master_form_talk.xslt';
    }

    showXML(divname, xmldoc, xsldoc, true, true, function () {
        var d = $('#' + divname);
        d.scrollTop(d.prop("scrollHeight"));

        if (typeof f == "function") f();
    });
    setTimeout(function () { refreshTalk(guid, '', location); }, 1000 * 60);
    //e.srcElement.focus();
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
