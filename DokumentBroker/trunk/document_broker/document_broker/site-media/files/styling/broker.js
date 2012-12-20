$(document).ready(function(){
    $('#temp-grid img, #temp-grid button').hover(function(){
        var newSrc;
        if($(this).parent().children('img').first().attr('src').indexOf("dummy-temp")==-1){
            newSrc = $(this).parent().children('img').first().attr('src').replace("_thumbnail","_example");
        } else {
            newSrc = "/document_broker/media/files/styling/trans.gif";
        }
        $('#preview-img').attr('src', newSrc);
    },
    function(){
        $('#preview-img').attr('src','/document_broker/media/files/styling/trans.gif');
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
		/*
         * For clarity we only show the preview button as a standard button
         * and leave the drop down effect for now.
        if($('.foldud li ul').hasClass('visible')) {
            $('.foldud li ul').addClass('hidden').removeClass('visible');
        } else if($('.foldud li ul').hasClass('hidden')){
            $('.foldud li ul').addClass('visible').removeClass('hidden');
        } else {
            $('.foldud li ul').addClass('visible');
        }
        */
        /*
         * We show the loading screen and generate the preview as a
         * asynchronous task.
         */
        // We fetch the field names.
        e.stopPropagation();
        // We need to tell tinyMCE to save our data before we can fetch it.
        tinyMCE.triggerSave();
        var num_fields = $('#number_of_fields').val();
        var field_data = {};
        for (var i=0; i < num_fields; i++) {
            field_data[$('#id_field_name_'+i).val()] = $('#id_document_field_'+i).val();
        }
        var data = {
            authentication: $('#authentication').val(),
            template_id: $('#template_id').val(),
            field_data: {
                items: field_data
            },
            return_format: "png",
            resolusion: 72
        }
        $.ajax({
            /* 
             * We point the relative URL back to the base URL, thus three
             * direcory levels up.
             */
            url: "../../../rest_api/test/generate_preview/",
            type: "POST",
            data: JSON.stringify(data),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success: function(data, textStatus, jqXHR) {
				/*
				 * We fetch the url to the generated preview image and
				 * change the location of the preview-img acordingly.
				 */
				$('#preview-img').attr('src',data.url);
			}
		});
        return false;
    });
    /*
    $('.foldud li ul li').click(function(){
        document.submitform.preview_format.value = $(this).attr('id');
        document.submitform.submit();
    });
    */
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
        // We show the loading screen.
        $('#spinner').show();
        document.submitform.submit();
    });
    $(document).ready(function(){
		$("#spinner").bind("ajaxSend", function() {
			$(this).show();
		}).bind("ajaxStop", function() {
			$(this).hide();
		}).bind("ajaxError", function() {
			$(this).hide();
		});
	});
});
