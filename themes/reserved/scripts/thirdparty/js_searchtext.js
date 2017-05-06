// JScript File
    function searchtext_onfocus()
    {
        var x=document.getElementById("searchtext");
        if (x.value=="search text") {
            x.value="";
            x.style.color="black";
        }
    }
    function searchtext_onblur()
    {
        var x=document.getElementById("searchtext");
        if (x.value=="") {
            x.value="search text";
            x.style.color="#B2B2B2";
        }
    }
