var start, lastStart;
var cell_changed = false;
var cell_added = false;

function cell_init(code) {

    $(".cell").each(function (i) {
        var c = $(".cell").eq(i);
        if ($(c).parent().data("code") == code && c.data('oldvalue') == undefined) {
            c.data('oldvalue', $(".cell").eq(i).html());
            c.click(function () {
                cell_focus(this);
            });
        }

    });

    $(".cell-editor-textbox").each(function (i) {
        var c = $(".cell").eq(i);
        if ($(c).parent().data("code") == code && $(".cell-editor-textbox").eq(i).attr('contenteditable') == undefined) {
            $(".cell-editor-textbox").eq(i).attr('contenteditable', 'true');
            $(".cell-editor-textbox").eq(i).attr('placeholder', 'Enter Text Here...');
        }
    });
    $(".cell-editor-datepicker").each(function (i) {
        var c = $(".cell").eq(i);
        if ($(c).parent().data("code") == code && $(".cell-editor-datepicker").eq(i).attr('contenteditable') == undefined) $(".cell-editor-datepicker").eq(i).attr('contenteditable', 'true');
    });

    $(".cell-editor-checkbox").each(function (i) {
        var c = $(".cell").eq(i);
        if ($(c).parent().data("code") == code && $(".cell-editor-checkbox").eq(i).find("input") == undefined) {
            var isChecked = ($(".cell-editor-checkbox").eq(i).html() == '1' ? 'checked' : '');
            $(".cell-editor-checkbox").eq(i).html("<input type='checkbox' " + isChecked + " />");
        }
    });

    $(".cell-editor-select2").each(function (i) {
        var c = $(".cell").eq(i);
        if ($(c).parent().data("code") == code) {
            //$(".cell-editor-select2").addClass("select2");
            $(".cell-editor-select2").eq(i).html('<span><select style="width:100%"></select></span>');
            $(".cell-editor-select2").eq(i).find('span').find("select").select2();

            $(".cell-editor-select2").eq(i).css("padding", "5px");
            $(".select2-container--default").eq(i).css("border", "0px");
            $(".select2-selection--single").eq(i).css("border", "0px");

            //$(".cell-editor-select2").eq(i).find('span').html('');
            $(".cell-editor-select2").eq(i).find('span').find("select").append($('<option>', { value: 'Tokyo', text: 'Tokyo' }));
            $(".cell-editor-select2").eq(i).find('span').find("select").append($('<option>', { value: 'Jakarta', text: 'Jakarta' }));
            $(".cell-editor-select2").eq(i).find('span').find("select").append($('<option>', { value: 'London', text: 'London' }));
            $(".cell-editor-select2").eq(i).find('span').find("select").val($(".cell-editor-select2").eq(i).data('oldvalue'));
            $(".cell-editor-select2").eq(i).find('span').find("select").on('open', function () {
                this.$search.attr('tabindex', 0);
                //self.$search.focus(); remove this line
                setTimeout(function () { this.$search.focus(); }, 10);//add this line})
            });

        }
    });

    $(".cell-recordSelector").each(function (i) {
        var c = $(".cell-recordSelector").eq(i);
        if ($(c).parent().data("code") == code && !c.find("span").is("span")) {
            c.html('<span><ix class="fa"></ix></span>');

            c.click(function () {

                if ($(this).children('span').find('ix').hasClass("fa-pencil")) cell_save(this);
                else //if (!$(this).children('span').find('ix').hasClass("fa-thumb-tack"))
                    cell_recordSelector(this);
            });

            c.mouseover(function () {
                if (!$(this).children('span').find('ix').hasClass("fa-thumb-tack") && !$(this).children('span').find('ix').hasClass("fa-pencil"))
                    $(this).children('span').find('ix').addClass("fa-caret-right");
            });

            c.mouseout(function () {
                if (!$(this).children('span').find('ix').hasClass("fa-thumb-tack") && !$(this).children('span').find('ix').hasClass("fa-pencil"))
                    $(this).children('span').find('ix').removeClass("fa-caret-right");
            });
        }
    });

    $('.cell-editor-datepicker').datepicker({
        autoclose: true
    }).on('changeDate', function (ev) {
        $(this).html(ev.date.getMonth() + 1 + '/' + ev.date.getDate() + '/' + ev.date.getFullYear());
    });
    $('.cell-editor-datepicker').focus(function () {
        $(this).datepicker("setDate", $(this).html());
    });
    $('.cell-editor-datepicker').blur(function () {
        $(this).datepicker("hide");
    });

    document.onkeydown = cell_keyCheck;


}

function cell_focus(sibling, mode) {	//mode=0 normal, mode=1 force, mode=2 save, mode=3 cancel
    if (mode == undefined) mode = 0;
    //if (cell_added && $(sibling).parent().attr("id") != $(start).parent().attr("id")) {
    //    showMessage("Please complete your new line, press ESC to cancel.", 1, start, function () { cell_setFocus(start); })

    //}
    if (sibling != null) {
        sibling.focus();
        if (start != sibling || mode == 1) {
            cell_blur(sibling);

            cell_setFocus(sibling);
            start = sibling;
        }
    }
}


function cell_keyCheck(e) {
    var kc = e.keyCode;
    e = e || window.event;
    if (e.keyCode == '9') {	//tab
        if (e.shiftKey) 	//shift-tab
            kc = 37;		//right
        else
            kc = 39;		//left
        e.preventDefault;
    }

    if (kc == '113') {
        if (!window.getSelection().isCollapsed)
            placeCaretAtEnd(start);
        else
            cell_focus(start, 1);

        event.preventDefault();

    } else if (kc == '27') {	//esc
        if (cell_added) cell_cancelAdded(start);
        else cell_cancelChange(start);

    } else if (kc == '38') {	//f2
        // up arrow
        var idx = start.cellIndex;
        var nextrow = start.parentElement.previousElementSibling;

        if (nextrow != null) {
            var sibling = nextrow.cells[idx];
            cell_focus(sibling);

        }
        event.preventDefault();

    } else if (kc == '40') {	// down arrow
        var idx = start.cellIndex;
        var nextrow = start.parentElement.nextElementSibling;
        if (nextrow != null) {
            var sibling = nextrow.cells[idx];
            cell_focus(sibling);

        }
        event.preventDefault();

    } else if (kc == '37') {	// left arrow
        if (!window.getSelection().isCollapsed) {
            var sibling = start.previousElementSibling;
            cell_focus(sibling);
            event.preventDefault();
        }
    } else if (kc == '39') {	// right arrow
        if (!window.getSelection().isCollapsed) {

            var sibling = start.nextElementSibling;
            cell_focus(sibling);
            event.preventDefault();
        }
    } else if ($(start).hasClass('cell-editor-checkbox') && kc == '32') {	//space for checkbox
        var c = $(start).find("input").prop("checked");
        $(start).find("input").prop("checked", !c);
        //($(start).find(".input").checked();
        event.preventDefault();
    } else if (kc != undefined) {   //any else
        cell_edit(start);
    }

}

function placeCaretAtEnd(el) {
    el.focus();
    if (typeof window.getSelection != "undefined"
            && typeof document.createRange != "undefined") {
        var range = document.createRange();
        range.selectNodeContents(el);
        range.collapse(false);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
    } else if (typeof document.body.createTextRange != "undefined") {
        var textRange = document.body.createTextRange();
        textRange.moveToElementText(el);
        textRange.collapse(false);
        textRange.select();
    }
}

function selectAllText(div) {
    //var div = document.getElementById("editable");

    div.onfocus = function () {
        window.setTimeout(function () {
            var sel, range;
            if (window.getSelection && document.createRange) {
                range = document.createRange();
                range.selectNodeContents(div);
                sel = window.getSelection();
                sel.removeAllRanges();
                sel.addRange(range);
            } else if (document.body.createTextRange) {
                range = document.body.createTextRange();
                range.moveToElementText(div);
                range.select();
            }
        }, 1);
    };
}

function cell_recordSelector(t) {
    $(t).parent().parent().find("tr").each(function (i) {
        $(t).parent().parent().find("tr").eq(i).find(".cell-recordSelector").children("span").children("ix").removeClass("fa-caret-right");
    })
    if ($(t).children("span").children("ix").hasClass("fa-thumb-tack")) {
        $(t).children("span").children("ix").removeClass("fa-thumb-tack");
        $(t).children("span").children("ix").addClass("fa-caret-right");
    }
    else {
        $(t).children("span").children("ix").removeClass("fa-caret-right");
        $(t).children("span").children("ix").addClass("fa-thumb-tack");
    }
}
function cell_cancelChange(t) {
    $(t).parent().children("td.cell").each(function (i) {

        var e = $(t).parent().children("td.cell").eq(i);

        if ($(e).hasClass("cell-editor-checkbox"))
            $(e).find("input").val($(start).data("oldvalue") == "1" ? true : false);
            //else if ($(e).hasClass("cell-editor-select2"))
        else if ($(e).hasClass("cell-editor-datepicker"))
            $(e).datepicker("setDate", $(e).data("oldvalue"));
        else
            $(e).html($(e).data("oldvalue"));
    })

    $(t).parent().find("td.cell-recordSelector").children("span").children("ix").removeClass("fa-pencil");
    $(t).parent().find("td.cell-recordSelector").children("span").children("ix").addClass("fa-caret-right");


    cell_changed = false;
}
function cell_setFocus(t) {
    $(t).attr('tabindex', '1');

    $(t).focus();
    if ($(t).hasClass("cell-editor-textbox") || $(t).hasClass("cell-editor-datepicker")) {
        //$(t).focus(function() {document.execCommand('selectAll', false, null)});

        selectAllText(t);
        $(t).focus();
    }
    else if ($(t).hasClass("cell-editor-select2")) {
        $(t).find("span").find("select").select2('open');
        $(".select2-search__field").focus();
    }
}
function cell_blur(next) {

    if ($(start).hasClass("cell-editor-select2")) {
        $(start).find("span").find("select").select2('close');
    }
    if ($(start).parent().attr("id") != $(next).parent().attr("id")) {

        cell_save(start)

        cell_clearTack(next);
        $(start).parent().find('.cell-recordSelector').children('span').find('ix').removeClass("fa-caret-right");
        $(next).parent().find('.cell-recordSelector').children('span').find('ix').addClass("fa-caret-right");  //start=next setelah save selesai

        //$(lastStart).parent().find('.cell-recordSelector').children('span').find('ix').removeClass("fa-caret-right");
        //$(start).parent().find('.cell-recordSelector').children('span').find('ix').addClass("fa-caret-right");  //start=next setelah save selesai
    }
    else {
    }
}

function cell_save(t, afterSuccess) {
    if (cell_changed || cell_added) {
        var code = $(t).parent().data("code");
        var guid = $(t).parent().data("guid");
        var formId = '';
        lastStart = start;

        saveFunction(code, guid, '30', formId, function (data) {
            var msg = $(data).children().find("message").text();
            var retguid = $(data).children().find("guid").text();

            if (isGuid(msg)) retguid = msg;    //compatible with old version

            if (retguid != "") {
                if (retguid == guid) {//update
                    $(lastStart).parent().children("td.cell").each(function (i) {
                        var h = $(lastStart).parent().children("td.cell").eq(i).html();
                        $(lastStart).parent().children("td.cell").eq(i).data("oldvalue", h);
                    })

                    //$(lastStart).parent().find("td.cell-recordSelector").find("ix").addClass("fa-caret-right");
                    $(lastStart).parent().find("td.cell-recordSelector").find("ix").removeClass("fa-pencil");

                    $(start).parent().find('.cell-recordSelector').children('span').find('ix').addClass("fa-caret-right");  //start=next setelah save selesai


                    cell_changed = false;
                    
                }
                else if (retguid != guid) {//new
                    $(lastStart).parent().data("guid", retguid);
                    $(lastStart).parent().attr("id", "tr1_" + $(lastStart).parent().data("code") + retguid);
                    //$(lastStart).parent().find("td.cell-recordSelector").find("ix").addClass("fa-caret-right");
                    $(lastStart).parent().find("td.cell-recordSelector").find("ix").removeClass("fa-pencil");

                    $(start).parent().find('.cell-recordSelector').children('span').find('ix').addClass("fa-caret-right");  //start=next setelah save selesai

                    cell_changed = false;
                    cell_added = false;
                }
                if (typeof afterSuccess == "function") afterSuccess(data);
            }
            else {//error
                showMessage(msg, 4);
                cell_changed = false;
                cell_focus(lastStart);
            }
        });
    }
}

function cell_edit(t) {
    cell_clearTack(t);
    $(t).parent().find("td.cell-recordSelector").find("ix").removeClass("fa-caret-right");
    $(t).parent().find("td.cell-recordSelector").find("ix").addClass("fa-pencil");
    cell_changed = true;
}

function cell_clearTack(t) {
    $(t).parent().parent().find("tr").each(function (i) {
        $(t).parent().parent().find("tr").eq(i).find("td.cell-recordSelector").find("ix").removeClass("fa-thumb-tack");
    });
}

function cell_add(code, columns) {
    if (cell_added) {
        cell_save(start, function () {
            cell_add(code, columns);
        });
    }
    else {
        var cx = columns.split(",");
        var columns_string = "";
        cx.forEach(function (i) {

            ix = i.split(":")
            if (ix[0] != " ")
                columns_string += "<td class='cell cell-editor-" + ix[0].trim() + "' data-field='" + ix[1] + "'></td>"
        });
        $("tbody#" + code + "").append("<tr id='tr1_" + code + "00000000-0000-0000-0000-000000000000' data-code='" + code + "' data-guid='00000000-0000-0000-0000-000000000000'><td class='cell-recordSelector'></td>" + columns_string + "</tr>")
        cell_init(code);
        n = $("#tr1_" + code + "00000000-0000-0000-0000-000000000000").find(".cell").eq(0);
        cell_focus(n);
        cell_added = true;
    }
}
function cell_cancelAdded(t) {
    $(t).parent().remove();
    cell_added = false;
    start = null;

}

function cell_delete(code) {
    var guidlist = [];
    $("tbody#" + code).children("tr").children("td.cell-recordSelector").children("span").children("ix.fa-thumb-tack").each(function (i) {
        guidlist.push($("tbody#" + code).children("tr").children("td.cell-recordSelector").children("span").children("ix.fa-thumb-tack").eq(i).parent().parent().parent().data("guid"));
    });
    if (guidlist.length > 0) {
        var g = guidlist.join(",")
        btn_function(code, g, 'delete', null, 30, null, function (data) {
            alert("deleted");
        });
    }
    else showMessage("Please tack at least one record to be deleted.", 4)
}