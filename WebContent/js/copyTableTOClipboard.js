function selectElementContents(el) {
    var body = document.body, range, sel;
    var css = "<link rel='stylesheet' href='styles.css' type='text/css'/>";

    /* $("<style id='myStyle' type='text/css'> " +
             " .table td, .table th {   padding: .01rem; }  </style>").appendTo("head");
    */
    if (document.createRange && window.getSelection) {
        range = document.createRange();
        sel = window.getSelection();
        sel.removeAllRanges();
        try {
            range.selectNodeContents(el);
            sel.addRange(range);
        } catch (e) {
            range.selectNode(el);
            sel.addRange(range);
        }
    } else if (body.createTextRange) {
        range = body.createTextRange();
        range.moveToElementText(el);
        range.select();
    }
    // Execute the copy command
    document.execCommand('copy');

}

