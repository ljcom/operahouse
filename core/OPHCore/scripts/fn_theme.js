﻿/*xml*/
function pushTheme(divname, xmldoc, xltdoc, clearBefore, f) {
    var req = [];
    req.push($.ajax({ url: xmldoc, error: function () { } }));
    //$.ajax({ url: 'somefile.dat', type: 'HEAD', error: do_something });
    xltdoc.forEach(function (item, index) {
        req.push($.ajax({
            url: item,
            error: function () { console.log(item + ' is not found') }
        }))
    })
    var callback = function (divnm, xml, xsl) {
        var clean = stripXML(stripScript(xmlToString(xml)));
        var hiddenText = findScript(xmlToString(xml));
        var hiddenMsg = findMsg(xmlToString(xml));
        if (hiddenText.length > 5 || clean.length < 5) {
            if (hiddenText.length > 5) ExecuteScript(xmlToString(xml), true);
            else top.window.location = '?';
        }
        else if (hiddenMsg.length > 0) { showMessage(hiddenMsg, 4);}
        else {
            if (isIE()) {
                var ex = TransformToHtmlText(clean, xsl.responseText)
                var cleanedT = stripScript(ex);
                cleanedT = cleanedT.split('&lt;').join('<').split('&gt;').join('>');
                if (document.getElementById(divnm)) document.getElementById(divnm).innerHTML = cleanedT;
                ExecuteScript(ex, true);
            }
                // code for Mozilla, Firefox, Opera, etc.
            else if (document.implementation && document.implementation.createDocument) {
                xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xsl);
                resultDocument = xsltProcessor.transformToFragment(xml, document);
                ex = xmlToString(resultDocument);
                // added 2016 09 30
                ex = ex.split('&lt;').join('<').split('&gt;').join('>').split('&amp;').join('&');
                var cleanedT = stripScript(ex);
                document.getElementById(divnm).innerHTML = cleanedT;
                ExecuteScript(ex, true);
            }
        }
        if (typeof f == "function") f();
    }

    $.when.apply(this, req).always(function (xml, xsl1, xsl2, xsl3, xsl4, xsl5) {
        if (isIE()) {
            if (xml && $.parseXML(xml[2].responseText)) {
                if (xml != undefined && xsl1 != undefined) callback(divname[0], xml[2], xsl1[2]);
                if (xml != undefined && xsl2 != undefined) callback(divname[1], xml[2], xsl2[2]);
                if (xml != undefined && xsl3 != undefined) callback(divname[2], xml[2], xsl3[2]);
                if (xml != undefined && xsl4 != undefined) callback(divname[3], xml[2], xsl4[2]);
                if (xml != undefined && xsl5 != undefined) callback(divname[4], xml[2], xsl5[2]);

                // add more if needed
            }
            else showMessage(xml[0], 4);
        } else {
            if (xml && ($.isXMLDoc(xml[0]))) {

                if (xml != undefined && xsl1 != undefined) callback(divname[0], xml[0], xsl1[0]);
                if (xml != undefined && xsl2 != undefined) callback(divname[1], xml[0], xsl2[0]);
                if (xml != undefined && xsl3 != undefined) callback(divname[2], xml[0], xsl3[0]);
                if (xml != undefined && xsl4 != undefined) callback(divname[3], xml[0], xsl4[0]);
                if (xml != undefined && xsl5 != undefined) callback(divname[4], xml[0], xsl5[0]);

                // add more if needed

            }
            else showMessage(xml[0], 4);
        }

    })

}
function showXML(divname, xmldoc, xsldoc, needRunSript, clearBefore, f) {
    $.when($.ajax(xmldoc), $.ajax(xsldoc)).done(function (a1, a2) {
        // code for IE
        var xml
        if (isIE()) {
            xml = a1[2];
            xsl = a2[2];
        } else {
            xml = a1[0];
            xsl = a2[0];
        }
        //if (xmlToString(xml) != '') {
        var clean = stripXML(stripScript(xmlToString(xml)));
        var hiddenText = findScript(xmlToString(xml));
        //alert(hiddenText);
        if (hiddenText.length > 5 || clean.length < 5) {
            //alert(xml);
            if (hiddenText.length > 5) ExecuteScript(xmlToString(xml), true);
            else top.window.location = '?';
        }
        else {
            if (isIE()) {
                var ex = TransformToHtmlText(clean, xsl.responseText)
                var cleanedT = stripScript(ex);
                cleanedT = cleanedT.split('&lt;').join('<').split('&gt;').join('>');
                if (document.getElementById(divname)) document.getElementById(divname).innerHTML = cleanedT;
                ExecuteScript(ex, needRunSript);
            }
                // code for Mozilla, Firefox, Opera, etc.
            else if (document.implementation && document.implementation.createDocument) {
                xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xsl);
                resultDocument = xsltProcessor.transformToFragment(xml, document);
                ex = xmlToString(resultDocument);
                // added 2016 09 30
                ex = ex.split('&lt;').join('<').split('&gt;').join('>');
                var cleanedT = stripScript(ex);
                document.getElementById(divname).innerHTML = cleanedT;
                ExecuteScript(ex, needRunSript);

            }
        }

        if (typeof f == "function") f();
        //}
    });

}

function TransformToHtmlText(xmlDoc, xsltDoc) {
    // 1.
    if (typeof (XSLTProcessor) != "undefined") {
        var xsltProcessor = new XSLTProcessor();
        xsltProcessor.importStylesheet(xsltDoc);
        var xmlFragment = xsltProcessor.transformToFragment(xmlDoc, document);

        if (typeof (GetXmlStringFromXmlDoc) != "undefined") {
            return GetXmlStringFromXmlDoc(xmlFragment);
        }
        else {
            // chrome friendly

            // get a xml serializer object
            var xmls = new XMLSerializer();

            // convert dom into string
            var sResult = xmls.serializeToString(xmlFragment);
            //extract contents of transform iix node if it is present
            if (sResult.indexOf("<transformiix:result") > -1) {
                sResult = sResult.substring(sResult.indexOf(">") + 1, sResult.lastIndexOf("<"));
            }
            return sResult;
        }
    }
    // 2.
    if (typeof (xmlDoc.transformNode) != "undefined") {
        return xmlDoc.transformNode(xsltDoc);
    }
    else {

        var activeXOb = null;
        try { activeXOb = new ActiveXObject("Msxml2.XSLTemplate"); } catch (ex) { }

        try {
            // 3
            if (activeXOb) {
                var xslt = activeXOb;
                var xslDoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
                xslDoc.loadXML(xsltDoc);
                xslt.stylesheet = xslDoc;
                var xslProc = xslt.createProcessor();

                var xmlDocs = new ActiveXObject("Msxml2.DOMDocument.3.0");
                xmlDocs.async = false;
                xmlDocs.loadXML(xmlDoc);

                xslProc.input = xmlDocs;
                xslProc.transform();

                return xslProc.output;
            }
        }
        catch (e) {
            // 4
            if (e.message) showMessage(e.message);
            else showMessage("The type [XSLTProcessor] and the function [XmlDocument.transformNode] are not supported by this browser, can't transform XML document to HTML string!");
            return null;
        }

    }
}


function stripScript(text) {
    var scripts = '';
    var cleaned = '';
    if (text) {
        cleaned = text.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function () {
            scripts += arguments[1] + '\n';
            return '';
        });
    }
    //if (cleaned) {
    //    cleaned2 = text.replace(/<css[^>]*>([\s\S]*?)<\/css>/gi, function () {
    //        scripts += arguments[1] + '\n';
    //        return '';
    //    });
    //}
    //else clean2 = clean;
    return cleaned;
};

function stripXML(text) {
    var scripts = '';
    var cleaned = '';
    if (text) {
        cleaned = text.split('<?xml version="1.0"?>').join('');
    }
    return cleaned;
};


function findScript(text) {
    var scripts = '';
    if (text) {
        var cleaned = text.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function () {
            scripts += arguments[1] + '\n';
            return '';
        });
    }
    return scripts;
}

function findMsg(text) {
    var msg = '';
    if (text) {
        var text3 = text.replace(/<message[^>]*>([\s\S]*?)<\/message>/gi, function () {
            msg += arguments[1] + '\n';
            msg = msg.replace(/<message>/gi, '');
            return '';
        });
    }
    return msg;
}

function ExecuteCSS(text, needRunSript) {
    var scripts = '';
    var cleaned = text.replace(/<css[^>]*>([\s\S]*?)<\/css>/gi, function () {
        scripts += arguments[1] + '\n';
        return '';
    });
    if (scripts && needRunSript)
        if (window.execScript) {
            window.execScript(scripts.split('&amp;').join('&').split("&gt;").join(">").split("&lt;").join("<"));
        } else {
            var scriptElement = document.createElement('script');
            scriptElement.type = 'text/javascript'; scriptElement.async = true;
            var s = document.getElementsByTagName('script')[0];
            scriptElement.text = scripts.split('&amp;').join('&').replace("<![CDATA[", "").replace("]]>", "");
            s.parentNode.insertBefore(scriptElement, s.nextSibling);

        }
    return cleaned;
};

function ExecuteScript(text, needRunSript) {
    var scripts = '';
    var cleaned = text.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function () {
        scripts += arguments[1] + '\n';
        return '';
    });
    if (scripts && needRunSript)
        if (window.execScript) {
            window.execScript(scripts.split('&amp;').join('&').split("&gt;").join(">").split("&lt;").join("<"));
        } else {
            var scriptElement = document.createElement('script');
            scriptElement.type = 'text/javascript'; scriptElement.async = true;
            var s = document.getElementsByTagName('script')[0];
            scriptElement.text = scripts.split('&amp;').join('&').replace("<![CDATA[", "").replace("]]>", "");
            s.parentNode.insertBefore(scriptElement, s.nextSibling);

        }
    return cleaned;
};

function attachScript(src) {
    var head = document.getElementsByTagName('head')[0];
    var scriptElement = document.createElement('script');
    scriptElement.setAttribute('type', 'text/javascript');
    scriptElement.setAttribute('src', src);
    head.appendChild(scriptElement);
    //head.removeChild(scriptElement);
}
/*xslt*/

//function setAsWelcomePages(curPage) {
//    try {
//        curPage = curPage.replace('&', '*').replace('&', '*').replace('&', '*').replace('&', '*');
//        //window.frames['framesetAsWelcomePage'].location = "OPHCore/api/msg_general.aspx?mode=3&curPage=" + curPage;
//        window.open('OPHCore/api/msg_general.aspx?mode=3&curPage=' + curPage);
//        //window.frames['frameBrowse'].location = "OPHCore/api/msg_general.aspx?mode=3&curPage=" + curPage
////        var div = document.getElementById("setAsWelcomePage");
////        document.getElementById(div).innerHTML = "<a class='labelUnder'>This page has been set as welcome page</a>";
//    }
//    catch (e) { }

//}



//var shiftPressed = false;
//var shiftStart = undefined;
//var shiftStartX, shiftStartWidth;

//function shiftMouseDown(e) {
//    shiftStart = $(this);
//    shiftPressed = true;
//    shiftStartX = e.pageX;
//    shiftStartWidth = $(this).width();
//}

//function shiftMouseUp(e) {
//    if (shiftPressed) {
//        shiftPressed = false;
//    }
//}

//$(document).mousemove(function (e) {
//    if (shiftPressed) {
//        $(shiftStart).width(shiftStartWidth + (e.pageX - shiftStartX));
//    }
//});

//customize syawal 2014/05/16 for perkalian antar textbox

//customize syawal 2014/05/16 for perkalian antar textbox



function clearGreyCheckBox(t) {
    //    var gno = t.groupCheckBox;
    // added 2016 09 30
    var gno = t.alt;
    if (gno != '') {
        if ($(t).data('checked') == 1) {
            $(t).data('checked', 2);
            $(t).prop('indeterminate', false);
            $(t).prop('checked', true);

            $("input[groupCheckBox='" + gno + "']").each(
            function (index) {
                el = $(this)
                //alert(el.prop('indeterminate'));
                if (el.prop('indeterminate')) {
                    el.data('checked', 0);
                    el.prop('indeterminate', false);
                    el.prop('checked', false);
                }
            });

        }
        else {
            xx = 0;
            $("input[groupCheckBox='" + gno + "']").each(
        function (index) {
            el = $(this)
            //alert(el.prop('indeterminate'));
            if (this.checked) xx++;
        });
            if (xx == 0) {
                $("input[groupCheckBox='" + gno + "']").each(
            function (index) {
                el = $(this)
                el.data('checked', 1);
                el.prop('indeterminate', true);
                el.prop('checked', false);
            });
            }
            else {

            }
        }
        //alert(gno);
    }
}


function xmlToString(xml) {
    try {
        if (isWebKit())
            xmlstr = new XMLSerializer().serializeToString(xml);
        else
            if (xml.responseText) xmlstr = xml.responseText;
            else xmlstr = xml;

        return xmlstr;
    } catch (e) { return xml }
}


function checkDevMode() {
    if (getQueryVariable("dev") == 1) {
        $('.devMode').css('display', 'inline');
    }
}



/**
 * function to load a given js file 

// load the js file 
loadScript("one.js");

 */

loadMeta = function (meta) {
    document.getElementsByTagName('head')[0].appendChild(meta);
}

loadScript = function (src) {
    var jsLink = $("<script src='" + src + "'>");
    $("head").append(jsLink);
};

function loadStyle(styleFile) {

    var link = document.createElement('link');
    link.setAttribute("rel", "stylesheet");
    link.setAttribute("type", "text/css");
    link.setAttribute("href", styleFile);
    document.getElementsByTagName('head')[0].appendChild(link);
}


