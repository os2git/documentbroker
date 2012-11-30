$(document).ready(function(){
    $('#temp-grid img, #temp-grid button').hover(function(){
        var newSrc;
        if($(this).parent().children('img').first().attr('src').indexOf("dummy-temp")==-1){
            newSrc = $(this).parent().children('img').first().attr('src').replace("_thumbnail","_example");
        } else {
            newSrc = "/media/files/styling/trans.gif";
        }
        $('#preview-img').attr('src', newSrc);
    },
    function(){
        $('#preview-img').attr('src','/media/files/styling/trans.gif');
    });
    $('#temp-grid img, #temp-grid button').click(function(){
        window.location = "show_fields/"+$(this).parent().attr('id');
        /*
        document.templateform.templatechoice.value = $(this).parent().attr('id');
        document.templateform.submit();
        */
    });
    $('.foldud li ul').addClass('hidden');
    $('html').click(function(){
        if($('.foldud li ul').hasClass('visible')) {
            $('.foldud li ul').removeClass('visible');
        }
    });
    $('.foldud').click(function(e){
        e.stopPropagation();
        if($('.foldud li ul').hasClass('visible')) {
            $('.foldud li ul').addClass('hidden').removeClass('visible');
        } else if($('.foldud li ul').hasClass('hidden')){
            $('.foldud li ul').addClass('visible').removeClass('hidden');
        } else {
            $('.foldud li ul').addClass('visible');
        }
        return false;
    });
    $('.foldud li ul li').click(function(){
        document.submitform.preview_format.value = $(this).attr('id');
        document.submitform.submit();
    });
    $('#id_sha1').click(function(e){
        document.finishform.command.value = "SHA1";
        document.finishform.submit();
    });
    $('#id_ack').click(function(e){
        document.finishform.command.value = "";
        document.finishform.submit();
    });
    $('.genpdf').click(function(){
        document.submitform.preview_format.value = "";
        document.submitform.submit();
    });
});
