/*global $*/

/*---JQuery Calls---*/
$(document).ready(function() {
$( "#searchForm" ).submit(function( event ) {
    event.preventDefault();
    $.ajax({
        type        : 'POST', // define the type of HTTP verb we want to use (POST for our form)
        url         : '/show', // the url where we want to POST
        data        : $(this).serializeArray(), // our data object
        dataType    : 'json', // what type of data do we expect back from the server
        encode      : true,
    }).done (function(returndata){
        if ($.fn.DataTable.isDataTable("#tableOutput")) {
          $('#tableOutput').DataTable().clear().destroy();
        }
            var keys = Object.keys(returndata[0]);
            var columnList = [];
            for (var i =0;i<keys.length; i++)
            {
                var obj = {};
                obj["data"] = keys[i];
                columnList.push(obj);
            }
            $("#tableOutput").DataTable({
            data: returndata,
            columns: columnList
            });
        });
    return false;
});
});