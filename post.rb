#post.rb

=begin


<script>

$(function(){
	$("input:nth-child(2)").click(function() {
	    $.ajax({
			type: "post",
			url: "/",
			data: $("form").serialize(), // serializes the forms elements.
			success: function() {
				$("html, body").animate({ scrollTop: $(document).height() }, "slow");
				return false;
			}
		});

	    return false;

	});
});



	function loadXMLDoc() {
		xml_http_request = new XMLHttpRequest();

		xml_http_request.onreadystatechange=function() {
		  	if (xml_http_request.readyState==4 && xml_http_request.status==200) {
			    document.getElementById("#database_texts").innerHTML=xml_http_request.responseText;
		    }
		}

		xml_http_request.open("post","/",true);

		xml_http_request.setRequestHeader("Content-type","application/x-www-form-urlencoded");

		xml_http_request.send(); //form_data
		
	}



</script>