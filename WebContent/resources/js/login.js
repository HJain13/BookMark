function checkLogin() {
    
    var userfield = $("input[name=loginname]");
    var passfield = $("input[name=password]");
    if ((userfield.val() != "") && (passfield.val() != "")) {
        return true;
    } else {
        $("#output").removeClass(' alert alert-success');
        $("#output").addClass("alert alert-danger animated fadeInUp").html("Please Enter Username & Password !!");
        return false;
    }
}

$('#btn_register').click(function(e) {
    e.preventDefault();
    $("#form_login").css({
        "display":"none"
    });
    $("#form_login").css({
        "display":"none"
    });    
    $("#loginH").css({
        "display":"none"
    });     
    $('#form_register').css({
        "display":"inline"
    });
    $('#registerH').css({
        "display":"inline"
    });    
    $('#form_init').css({
        "display":"none"
    });
    $(".avatar").css({
        "background-image": "url('resource/register.gif')"
    });
});

$('#btn_cancel').click(function(e) {
    e.preventDefault();
    location.href = "index.jsp";
});

function checkRegister() {

    var itemfield1 = $('input[name=loginname_r]');
    var itemfield2 = $('input[name=password_r]');
    var itemfield3 = $('input[name=fullname_r]');
    var itemfield4 = $('input[name=address_r]');
    var itemfield5 = $('input[name=phone_r]');
    if (itemfield1.val() == "" || itemfield2.val() == "" || 
        itemfield3.val() == "" || itemfield4.val() == "" || itemfield5.val() == "" ) {
        $("#output").removeClass(' alert alert-success');
        $("#output").addClass("alert alert-danger animated fadeInUp").html("Please Enter ALL Items !!");
        return false;
    }
    return true;
}