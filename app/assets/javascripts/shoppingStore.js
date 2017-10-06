/*global $*/

/*---JQuery Calls---*/
$(document).ready(function() {
$( "#searchForm" ).submit(function( event ) {

    $.ajax({
        type        : 'POST', // define the type of HTTP verb we want to use (POST for our form)
        url         : '/show', // the url where we want to POST
        data        : $(this).serializeArray(), // our data object
        dataType    : 'json', // what type of data do we expect back from the server
        encode      : true,
    }).done (function(returndata){
            $("#tableOutput").DataTable({
            data: returndata,
            columns: [
            {data :'id'},
            {data :'name'},
            {data :'contact'},
            {data :'email'}
            ]
            });
        });
  event.preventDefault();
});
});