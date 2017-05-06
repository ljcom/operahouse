/**
* An autosuggest textbox control.
* @class
* @scope public
*/
function AutoSuggestControl(oTextbox /*:HTMLInputElement*/,
        oProvider, oImage, otablename, opreview/*:SuggestionProvider*/) {
    /**
    * The currently selected suggestions.
    * @scope private
    */
    this.cur /*:int*/ = -1;
    /**
    * The dropdown list layer.
    * @scope private
    */
    this.layer = null;
    /**
    * Suggestion provider for the autosuggest feature.
    * @scope private.
    */
    this.provider /*:SuggestionProvider*/ = oProvider;
    this.tablename = otablename;
    this.preview = opreview;
    /**
    * The textbox to capture.
    * @scope private
    */
    this.textbox /*:HTMLInputElement*/ = oTextbox;
    this.image = oImage;
    //initialize the control
    this.init();
}

/**
* Initializes the textbox with event handlers for
* auto suggest functionality.
* @scope private
*/
AutoSuggestControl.prototype.init =
function () {
    //save a reference to this object
    var oThis = this;
    try {
        this.image.onclick = function () {
            if (!oThis.textbox.readOnly && !oThis.textbox.disabled) {
                oThis.textbox.value = "";
                oThis.textbox.focus();
                oThis.provider.requestSuggestions(oThis, false);
            }
        }
        //assign the onkeyup event handler
        this.textbox.onkeyup = function (oEvent) {
            //check for the proper location of the event object
            if (!oEvent) {
                oEvent = window.event;
            }
            //call the handleKeyUp() method with the event object
            oThis.handleKeyUp(oEvent);
        };
        //assign onkeydown event handler
        this.textbox.onkeydown = function (oEvent) {
            //check for the proper location of the event object
            if (!oEvent) {
                oEvent = window.event;
            }
            //call the handleKeyDown() method with the event object
            oThis.handleKeyDown(oEvent);
        };
        //assign onblur event handler (hides suggestions)
        this.textbox.onblur = function () {
            if (document.activeElement != oThis.layer) {
                oThis.hideSuggestions();
                var x;
                x = document.getElementById(oThis.textbox.name.substr(0, oThis.textbox.name.length - 5)).value;
                if (x == undefined) x = document.forms(0).elements(oThis.textbox.name.substr(0, oThis.textbox.name.length - 5)).value;
                if (x.length != 38 && x.length != 36 && oThis.textbox.name.substring(oThis.textbox.name.length - 9, oThis.textbox.name.length - 5) == "GUID") {
                    oThis.textbox.value = '';
                }
                if (oThis.tablename) {
                    if (oThis.preview > 0) {
                        preview(oThis.preview, oThis.tablename);
                    } else {
                        preview(0, oThis.tablename);
                    }
                } else {
                    SaveOtherField(oThis.textbox.name);
                }
                //preview(oThis.tablename);
                //SaveOtherField(oThis.textbox.name);
                if (oThis.textbox.name.substring(oThis.textbox.name.length - 4, oThis.textbox.name.length - 0) == "filt") {
                    doFilterBrowse(oThis.textbox.name);
                }
            }
            else { oThis.textbox.focus(); };
        };
        //create the suggestions dropdown
        this.createDropDown();
    }
    catch (e) { }
};

/**
* Autosuggests one or more suggestions for what the user has typed.
* If no suggestions are passed in, then no autosuggest occurs.
* @scope private
* @param aSuggestions An array of suggestion strings.
* @param bTypeAhead If the control should provide a type ahead suggestion.
*/
AutoSuggestControl.prototype.autosuggest =
function (aSuggestions /*:Array*/,
bTypeAhead
    /*:boolean*/) {
    //make sure there's at least one suggestion
    try {
        if (aSuggestions.length > 0) {
            if (bTypeAhead) {
                this.typeAhead(aSuggestions[0]);
            }
            this.showSuggestions(aSuggestions);
        }
        else {
            this.hideSuggestions();
        }
    }
    catch (e) { }
};
/**
* Creates the dropdown layer to display multiple suggestions.
* @scope private
*/
AutoSuggestControl.prototype.createDropDown =
function () {
    //if (!this.textbox.readOnly) {
    try {
        var oThis = this;
        //create the layer and assign styles
        this.layer = document.createElement("div");
        this.layer.className = "Suggestions";
        this.layer.style.visibility = "hidden";
        this.layer.style.maxHeight = 150;
        this.layer.style.overflowY = 'auto';
        if (this.textbox.offsetWidth != 0) {
            this.layer.style.minWidth = this.textbox.offsetWidth;
            this.layer.style.width = 'auto';
        }
        else {
            this.layer.style.minWidth = 150;
            this.layer.style.width = 'auto';
            //this.layer.style.width = 150;
        }
        // this.layer.style.height = "100px";
        // this.layer.style.overflow = "scroll";
        //when the user clicks on the a suggestion, get the text (innerHTML)
        //and place it into a textbox
        this.layer.onmousedown =
        this.layer.onmouseup =
        this.layer.onmouseover = function (oEvent) {
            oEvent = oEvent || window.event;
            oTarget = oEvent.target || oEvent.srcElement;
            if (oEvent.type == "mousedown") {
                if (oTarget.name != undefined) {
                    if (oTarget.firstChild.nodeValue != 'null') {
                        oThis.textbox.value = oTarget.firstChild.nodeValue;
                        var f = oThis.textbox.name.substr(0, oThis.textbox.name.length - 5);
                        document.getElementById(f).value = oTarget.name.replace('{', '').replace('}', '');
                        //document.forms(0).elements(f).value = oTarget.name.replace('{', '').replace('}', ''); syawal
                        oThis.hideSuggestions();
                    }
                }
                var sRtn;
                // SaveOtherField(oThis.textbox.name.substr(0,oThis.textbox.name.length-5), sRtn);
            }
            else if (oEvent.type == "mouseover") {
                oThis.highlightSuggestion(oTarget);
            }
            else {
                oThis.textbox.focus();
            }
        };
        document.body.appendChild(this.layer);
    }
    catch (e) { }
    //}
};
/**
* Gets the left coordinate of the textbox.
* @scope private
* @return The left coordinate of the textbox in pixels.
*/
AutoSuggestControl.prototype.getLeft =
function () /*:int*/ {
    var oNode = this.textbox;
    var iLeft = 0;
    while (oNode.tagName != "BODY") {
        iLeft += oNode.offsetLeft;
        oNode = oNode.offsetParent;
    }
    return iLeft;
};
/**
* Gets the top coordinate of the textbox.
* @scope private
* @return The top coordinate of the textbox in pixels.
*/
AutoSuggestControl.prototype.getTop =
function () /*:int*/ {
    var oNode = this.textbox;
    var iTop = 0;
    while (oNode.tagName != "BODY") {
        iTop += oNode.offsetTop;
        oNode = oNode.offsetParent;
    }
    return iTop;
};
/**
* Handles three keydown events.
* @scope private
* @param oEvent The event object for the keydown event.
*/
AutoSuggestControl.prototype.handleKeyDown =
function (oEvent /*:Event*/) {
    //if (!this.readOnly) {
    switch (oEvent.keyCode) {
        case 38: //up arrow
            this.previousSuggestion();
            break;
        case 40: //down arrow 
            this.nextSuggestion();
            break;
        case 13: //enter
            var cSuggestionNodes = this.layer.childNodes;
            if (cSuggestionNodes.length > 0 && this.cur < cSuggestionNodes.length - 1) {
                if (this.cur >= 0) {
                    var oNode = cSuggestionNodes[this.cur];
                    this.textbox.value = oNode.firstChild.nodeValue;
                    var f = this.textbox.name.substr(0, this.textbox.name.length - 5);
                    document.getElementById(f).value = oNode.name;
                    var sRtn;
                    this.textbox.value = oNode.firstChild.nodeValue;
                    var f = this.textbox.name.substr(0, this.textbox.name.length - 5);
                    document.getElementById(f).value = oNode.name.replace('{', '').replace('}', '');
                }
            }
            this.hideSuggestions();
            var sRtn;
            break;
    }
    //}
};
/**
* Handles keyup events.
* @scope private
* @param oEvent The event object for the keyup event.
*/
AutoSuggestControl.prototype.handleKeyUp =
function (oEvent /*:Event*/) {
    var iKeyCode = oEvent.keyCode;
    //for backspace (8) and delete (46), shows suggestions without typeahead
    if (iKeyCode == 8 || iKeyCode == 46) {
        //this.provider.requestSuggestions(this, false);
        ox = this.textbox.value;
        tx = this;
        m = 1;
        //if (this.textbox.value==o) this.provider.requestSuggestions(this, false);
        //make sure not to interfere with non-character keys
    }
    else if (iKeyCode < 32 || (iKeyCode >= 33 && iKeyCode < 36) || (iKeyCode >= 38 && iKeyCode < 46) || (iKeyCode >= 112 && iKeyCode <= 123)) {
        //ignore
    }
    else {
        //request suggestions from the suggestion provider with typeahead
        ox =
this.textbox.value;
        tx =
this;
        m = 1;
        //if (this.textbox.value==o) this.provider.requestSuggestions(this, false);
    }
};


/**
* Hides the suggestion dropdown.
* @scope private
*/
AutoSuggestControl.prototype.hideSuggestions =
function () {
    this.layer.style.visibility = "hidden";
};
/**
* Highlights the given node in the suggestions dropdown.
* @scope private
* @param oSuggestionNode The node representing a suggestion in the dropdown.
*/
AutoSuggestControl.prototype.highlightSuggestion =
function (oSuggestionNode) {
    try {
        for (var i = 0; i < this.layer.childNodes.length; i++) {
            var oNode = this.layer.childNodes[i];
            if (oNode == oSuggestionNode) {
                oNode.className =
"current";
            }
            else if (oNode.className == "current") {
                oNode.className =
"";
            }
        }
    }
    catch (e) { }
};

/**
* Highlights the next suggestion in the dropdown and
* places the suggestion into the textbox.
* @scope private
*/
AutoSuggestControl.prototype.nextSuggestion =
function () {
    try {
        var cSuggestionNodes = this.layer.childNodes;
        if (cSuggestionNodes.length > 0 && this.cur < cSuggestionNodes.length - 1) {
            var oNode = cSuggestionNodes[++this.cur];
            this.highlightSuggestion(oNode);
            this.textbox.value = oNode.firstChild.nodeValue;
            var f = this.textbox.name.substr(0, this.textbox.name.length - 5);
            document.getElementById(f).value = oNode.name;
            var sRtn;
            // SaveOtherField(oThis.textbox.name.substr(0,oThis.textbox.name.length-5), sRtn);
            this.getElementsByName(textbox.name) = oNode.name;
            alert(oNode.name);
        }
    }
    catch (e) { }
};
/**
* Highlights the previous suggestion in the dropdown and
* places the suggestion into the textbox.
* @scope private
*/
AutoSuggestControl.prototype.previousSuggestion =
function () {
    try {
        var cSuggestionNodes = this.layer.childNodes;
        if (cSuggestionNodes.length > 0 && this.cur > 0) {
            var oNode = cSuggestionNodes[--this.cur];
            this.highlightSuggestion(oNode);
            this.textbox.value = oNode.firstChild.nodeValue;
            var f = this.textbox.name.substr(0, this.textbox.name.length - 5);
            document.getElementById(f).value = oNode.name;
            var sRtn;
            // SaveOtherField(oThis.textbox.name.substr(0,oThis.textbox.name.length-5), sRtn);
            this.getElementsByName(textbox.name) = oNode.name;
            alert(oNode.name);
        }
    }
    catch (e) { }
};
/**
* Selects a range of text in the textbox.
* @scope public
* @param iStart The start index (base 0) of the selection.
* @param iLength The number of characters to select.
*/
AutoSuggestControl.prototype.selectRange =
function (iStart /*:int*/, iLength /*:int*/) {
    //use text ranges for Internet Explorer
    if (this.textbox.createTextRange) {
        var oRange = this.textbox.createTextRange();
        oRange.moveStart("character", iStart);
        oRange.moveEnd("character", iLength - this.textbox.value.length);
        oRange.select();
        //use setSelectionRange() for Mozilla
    }
    else if (this.textbox.setSelectionRange) {
        this.textbox.setSelectionRange(iStart, iLength);
    }
    //set focus back to the textbox
    this.textbox.focus();
};
/**
* Builds the suggestion layer contents, moves it into position,
* and displays the layer.
* @scope private
* @param aSuggestions An array of suggestions for the control.
*/
AutoSuggestControl.prototype.showSuggestions = function (aSuggestions /*:Array*/) {
    if (!this.textbox.readOnly) {
        var oDiv = null;
        var oTextNode = null;
        this.layer.innerHTML = ""; //clear contents of the layer
        var f = this.textbox.name.substr(0, this.textbox.name.length - 5);
        document.getElementById(f).value = "";

        for (var i = 0; i < aSuggestions.length; i++) {
            oDiv = document.createElement("div");
            oTextNode = document.createTextNode(aSuggestions[i].substr(0, aSuggestions[i].indexOf("{", 0)));
            oDiv.appendChild(oTextNode);
            oDiv.name = aSuggestions[i].substr(aSuggestions[i].indexOf("{", 0));
            this.layer.appendChild(oDiv);
        }
        this.layer.style.left = this.getLeft() + "px";
        this.layer.style.top = (this.getTop() + this.textbox.offsetHeight) + "px";
        this.layer.style.maxHeight = 172;
        this.layer.style.overflowY = 'auto';
        if (this.textbox.offsetWidth != 0) {
            this.layer.style.minWidth = this.textbox.offsetWidth;
            this.layer.style.width = 'auto';
        }
        else {
            this.layer.style.minWidth = 150;
            this.layer.style.width = 'auto';
        }

        // this.layer.style.height = "100px";
        // this.layer.style.overflow = "scroll";
        this.layer.style.visibility = "visible";
    }
};
/**
* Inserts a suggestion into the textbox, highlighting the 
* suggested part of the text.
* @scope private
* @param sSuggestion The suggestion for the textbox.
*/
AutoSuggestControl.prototype.typeAhead =
function (sSuggestion /*:String*/) {
    //check for support of typeahead functionality
    if (this.textbox.createTextRange || this.textbox.setSelectionRange) {
        var iLen = this.textbox.value.length;
        this.textbox.value = sSuggestion.substr(0, sSuggestion.indexOf("{", 0))
        this.selectRange(iLen, sSuggestion.length);
    }
};



var m, tx, ox;

function loopForever() {
    if (m == 1 && tx.textbox.value == ox) {
        tx.provider.requestSuggestions(tx,
false);
        m = 0;
    }
    setTimeout("loopForever()", 1000);
}
setTimeout("loopForever()", 1000);