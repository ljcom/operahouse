function moveSpan(oldSpan, newSpan) {
    if ((oldSpan != null) && (newSpan != null)) {
        newSpan.innerHTML = oldSpan.innerHTML;
        oldSpan.innerHTML = '';
    }
}

function comboSync(elguid, elkey, elname) {
    elguid.value = elkey.value;
    if (elname != undefined)
        elname.value = elkey.value;
    //alert(elkey.value);

}
function jumpTo(hrefstr) {
    var n;

    location.href = hrefstr;
}
function popTo(hrefstr, isModal, popUpX, popUpY) {
    var n;
    if (!isModal)
        window.open(hrefstr);
    else {
        if (showModalDialog) {
            var sRtn;
            sRtn = showModalDialog(hrefstr, "", "center=yes;status=no;help=no;dialogWidth=" + popUpX + "px;dialogHeight=" + popUpY + "px");
            if (sRtn[0] == 1) {
                hrefstr = location.href;
                if (hrefstr.indexOf('?') == -1) hrefstr += '?';
                else hrefstr = hrefstr.substr(0, hrefstr.indexOf('?') + 1);

                if (hrefstr.substr(hrefstr.length - 1, 1) != '&' && hrefstr.substr(hrefstr.length - 1, 1) != '?') hrefstr += '&';
                hrefstr = hrefstr + 'par1=' + sRtn[1] + '&par2=' + sRtn[2] + '&par3=' + sRtn[3];
                location.href = hrefstr;
            }
        }
        else
            alert("Internet Explorer 4.0 or later is required.")
    }
}

function doNothing() { }


function doCal(elTarget, curDate) {
    if (showModalDialog) {
        var sRtn;
        sRtn = showModalDialog("../pages/Calendar.htm?curDate=" + curDate, "", "center=yes;status=no;help=no;dialogWidth=180pt;dialogHeight=190pt");
        if (sRtn != "")
            elTarget.value = sRtn;
        SaveOtherField(elTarget.name, sRtn);
    }
    else
        alert("Internet Explorer 4.0 or later is required.")
}

function blockInput(id, digit, mode) {
    var val = document.getElementById(id).value;  // eval('document.all.' + id + '.value');
    if (digit != "" ) {

        if (!((event.keyCode >= 48 && event.keyCode <= 57)
            || (event.keyCode == 46 && val.indexOf('.') == -1)    //dot
            || (event.keyCode == 44 && val.indexOf(',') == -1)    //comma
            || event.keycode == 8)) {

            //minus
            if (event.keyCode == 45 && val.indexOf('-') == -1) document.getElementById(id).value = "-" + val;

            event.keyCode = '';
        } 
    }
}


function checkInput(id, digit, mode) {
    //mode=EN:comma, ID:dot
    if (digit != "") {
        var val = document.getElementById(id).value;  // eval('document.all.' + id + '.value');

        if (mode == 'EN') {
            thousandSign = ',';
            decSign = '.'
        }
        else {
            thousandSign = '.';
            decSign = ','
        }

        val = val.split(thousandSign).join('');
        x = val.split(decSign);
        x1 = parseInt(x[0], 10) + '';
        x2 = x.length > 1 ? decSign + x[1].substring(0, digit) : '';
        if (x2 == '.') x2 = '';

        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + thousandSign + '$2');
        }
        val = x1 + x2;
        document.getElementById(id).value = val;
    }
}


function cekinput(datatype, id) {
    var value = eval('document.all.' + id + '.value');
    if (datatype == 'Single' || datatype == 'Double' || datatype == 'Decimal' || datatype.substring(0, 3) == 'Int') {
        if (!((event.keyCode >= 48 && event.keyCode <= 57) || event.keyCode == 46 || event.keyCode == 45 || event.keycode == 8)) {
            event.keyCode = '';
            eval('document.all.' + id + '.value=value');
        }
        if ((event.keyCode == 45 && value.indexOf('-') == 0) || (event.keyCode == 46 && value.indexOf('.') > 0)) {
            event.keyCode = '';
            eval('document.all.' + id + '.value=value');
        }
    }
}
function cekspace(id) {
    if (document.createEventObject) {
        var evt = document.createEventObject();
        evt.keyCode = 32;
        document.getElementById(id).fireEvent("onkeypress", evt);
    }

}

function cektanda(datatype, id) {
    var value, value1, minus, titik;
    value = document.getElementById(id).value;
    minus = value.indexOf('-');
    titik = value.indexOf('.');
    if (datatype == 'Single' || datatype == 'Double' || datatype == 'Decimal' || datatype.substring(0, 3) == 'Int') {
        if (titik == 0 || (titik == 1 && minus == 0)) {
            value = value.replace(value.substring(titik, titik + 1), '');
            eval('document.all.' + id + '.value=value');
        }

        value1 = value.substring(0, 1);
        value2 = value.substring(1, value.length);
        if (value2.indexOf('-') > -1) {
            value2 = value2.replace(value2.substring(value2.indexOf('-'), value2.indexOf('-') + 1), '');
            value = value1 + value2;
            eval('document.all.' + id + '.value=value');
        }
    }
}


function addHTML(id, textbelow, htmlText) {
    eval('document.all.' + id + '.innerHTML=document.all.' + id + '.innerHTML.replace(textbelow,htmlText)');
}

function activateField(linkedfield, field) {
    if (eval('document.all.' + field + '.checked') == true)
        eval('document.all.' + linkedfield + '.readOnly=false');
    else
        eval('document.all.' + linkedfield + '.readOnly=true');
}

function fn_global(number, digit, mode) {
    var jmldigit, jmlkoma, index, result, number1, isdecimal, isminus;
    if (mode == 'ID')
        number = number.replace('.', '');
    else
        number = number.replace(',', '');

    index = 1;
    isdecimal = 0;
    isminus = '';
    if (number.indexOf('-') > -1) {
        isminus = '-';
        number = number.substring(1, number.length);
    }
    if (mode == 'ID') {
        decimalmode = ',';
        separatormode = '.';
    }
    else {
        decimalmode = '.';
        separatormode = ',';
    }
    result = '';
    number1 = number;

    if (number.indexOf('.') > 0) {
        number = number.substring(0, number.indexOf('.'));
        isdecimal = 1;
    }

    // ini untuk menghitung jumlah digit ribuan
    jmldigit = number.length;
    jmlkoma = jmldigit / 3;
    if (jmlkoma < 1) {
        result = number;
    }
    else {
        while (jmldigit > 0) {

            result += number.substring(index - 1, index);
            jmldigit--;

            if (jmldigit % 3 == 0 && jmlkoma > 1) {
                result += separatormode;
                jmlkoma--;
            }
            index++;
        }
    }

    if (isminus != '') result = isminus + result;

    if (isdecimal == 1 && digit > 0)
        result += decimalmode + number1.substring(number1.indexOf('.') + 1, number1.indexOf('.') + 1 + digit);

    return result;
}

function fn_curr(money, digit, language) {
    money = money.replace(',', '');
    money = money.replace(',', '');
    money = money.replace(',', '');
    money = money.replace(',', '');
    money = money.replace(',', '');
    if (money.indexOf('.0000') > -1) {
        money = money.substring(0, money.indexOf('.0000')) + money.substring(money.indexOf('.0000'), money.indexOf('.0000') + digit + 1);
    }

    return fn_global(money, digit, language);
}
function Left(str, n) {
    if (n <= 0)
        return "";
    else if (n > String(str).length)
        return str;
    else
        return String(str).substring(0, n);
}

function IsNumeric(sText) {
    var ValidChars = "0123456789.";
    var IsNumber = true;
    var Char;


    for (i = 0; i < sText.length && IsNumber == true; i++) {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) == -1) {
            IsNumber = false;
        }
    }
    return IsNumber;

}
function cInt(n, m) {
    return parseInt(n.replace(',', ''), m)
}


function autogrow(t) {
    if (isMSIE()) {
        t.style.height = t.scrollHeight + "px";
    } else {
        t.style.height = (t.scrollHeight - 2) + "px";
    }
    if (t.scrollHeight < 28) t.style.height = '28px';
}
function initBarChart() { }


function setCursorWait(t) {
    //
    if (t) if (t.style) if (t.style.cursor!='undefined') t.style.cursor = 'wait';

    if (top.document.getElementById("frameWait"))
        if (top.document.getElementById("frameWait").style)
            if (top.document.getElementById("frameWait").style.display)
                top.document.getElementById("frameWait").style.display = "inline";

    spin("frameWait");
}
function setCursorHand(t) {
    if (t) if (t.style) if (t.style.cursor) t.style.cursor = 'hand';
}
function setCursorDefault(t) {
    if (t) if (t.style) if (t.style.cursor) t.style.cursor = 'default';

    if (top.document.getElementById("frameWait"))
        if (top.document.getElementById("frameWait").style)
            if (top.document.getElementById("frameWait").style.display)
                top.document.getElementById("frameWait").style.display = "none";

}
function popupError(txt) {
    alert(txt);
    if (top.document.getElementById("frameWait"))
        if (top.document.getElementById("frameWait").style)
            if (top.document.getElementById("frameWait").style.display)
                top.document.getElementById("frameWait").style.display = "none";
}
function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0].toLowerCase() == variable.toLowerCase()) {
            return unescape(pair[1]);
        }
    }
}

if (!String.prototype.trim) {
    String.prototype.fulltrim = function () { return this.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g, '').replace(/\s+/g, ' '); }
}

function Right(str, n) {
    if (n <= 0)
        return "";
    else if (n > String(str).length)
        return str;
    else {
        var iLen = String(str).length;
        return String(str).substring(iLen, iLen - n);
    }
}

function isIE() { return ((navigator.appName == 'Microsoft Internet Explorer') || ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null))); }

function isMSIE() {
    return '\v' == 'v';
}
function isWebKit() { return ((/Chrome[\/\s](\d+\.\d+)/.test(navigator.userAgent)) || (/Safari[\/\s](\d+\.\d+)/.test(navigator.userAgent))); }


function atEndofPage() {
    return document.body.scrollHeight - $(this).scrollTop() <= $(this).height();
}
function GetTopLeft(elm) {

    var x, y = 0;

    //set x to elm’s offsetLeft
    x = elm.offsetLeft;


    //set y to elm’s offsetTop
    y = elm.offsetTop;


    //set elm to its offsetParent
    elm = elm.offsetParent;


    //use while loop to check if elm is null
    // if not then add current elm’s offsetLeft to x
    //offsetTop to y and set elm to its offsetParent

    while (elm != null) {

        x = parseInt(x) + parseInt(elm.offsetLeft);
        y = parseInt(y) + parseInt(elm.offsetTop);
        elm = elm.offsetParent;
    }

    //here is interesting thing
    //it return Object with two properties
    //Top and Left

    return { Top: y, Left: x };

}
function spin(target) {

    var opts = {
        lines: 11, // The number of lines to draw
        length: 11, // The length of each line
        width: 2, // The line thickness
        radius: 0, // The radius of the inner circle
        corners: 1, // Corner roundness (0..1)
        rotate: 51, // The rotation offset
        direction: 1, // 1: clockwise, -1: counterclockwise
        color: '#000', // #rgb or #rrggbb or array of colors
        speed: 0.5, // Rounds per second
        trail: 10, // Afterglow percentage
        shadow: false, // Whether to render a shadow
        hwaccel: false, // Whether to use hardware acceleration
        className: 'spinner', // The CSS class to assign to the spinner
        zIndex: 2e9, // The z-index (defaults to 2000000000)
        top: '50%', // Top position relative to parent
        left: '50%' // Left position relative to parent
    };
    var el = document.getElementById(target);
    var spinner = new Spinner(opts).spin(el);

}
function recoverSpecialChar(text) {
    return text.split('&lt;').join('<').split('&gt;').join('>');
}
function getScrollBarWidth() {
    var inner = document.createElement('p');
    inner.style.width = "100%";
    inner.style.height = "200px";

    var outer = document.createElement('div');
    outer.style.position = "absolute";
    outer.style.top = "0px";
    outer.style.left = "0px";
    outer.style.visibility = "hidden";
    outer.style.width = "200px";
    outer.style.height = "150px";
    outer.style.overflow = "hidden";
    outer.appendChild(inner);

    document.body.appendChild(outer);
    var w1 = inner.offsetWidth;
    outer.style.overflow = 'scroll';
    var w2 = inner.offsetWidth;
    if (w1 == w2) w2 = outer.clientWidth;

    document.body.removeChild(outer);

    return w1 - w2;  //($('body').height==$(window).height ) ? 0 : (w1 - w2);
};

//Latu 20130524: get cookie for menu
function getCookie(c_name) {
    var c_value = document.cookie;
    var c_start = c_value.indexOf(" " + c_name + "=");
    if (c_start == -1) {
        c_start = c_value.indexOf(c_name + "=");
    }
    if (c_start == -1) {
        c_value = null;
    }
    else {
        c_start = c_value.indexOf("=", c_start) + 1;
        var c_end = c_value.indexOf(";", c_start);
        if (c_end == -1) {
            c_end = c_value.length;
        }
        c_value = unescape(c_value.substring(c_start, c_end));
    }
    return c_value;
}

//Latu 20130524: set cookie for menu
function setCookie(c_name, value, exdays, exHours, exMinutes) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    exdate.setHours(exdate.getHours() + exHours);
    exdate.setMinutes(exdate.getMinutes() + exMinutes);
    var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString() + "; path=/");
    document.cookie = c_name + "=" + c_value;
}

//Latu 20130524: set cookie for menu
function checkCookie(level) {
    var button_selected = getCookie("button_" + level);

    //Latu 20130524: check, cookie exist or not
    if (button_selected != null && button_selected != "") {
        alert("button_" + level + " = " + button_selected);
        return button_selected;
    }
    else {
        button_selected = prompt("Please enter your name:", "");
        if (button_selected != null && button_selected != "") {
            setCookie("button_" + level, button_selected, 30, 0, 0);
        }
    }
}

function zeroGUID() { return '00000000-0000-0000-0000-000000000000'; }

function isGuid(value) {
    var regex = /[a-f0-9]{8}(?:-[a-f0-9]{4}){3}-[a-f0-9]{12}/i;
    var match = regex.exec(value);
    return match != null;
}


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
