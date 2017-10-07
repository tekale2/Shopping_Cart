/*global $*/

/*---JQuery Calls---*/
$(document).ready(function() {
var table;
$( "#searchForm" ).submit(function( event ) {
    event.preventDefault();
    $.ajax({
        type        : 'POST', // define the type of HTTP verb we want to use (POST for our form)
        url         : $('#urlVal').val(), // the url where we want to POST
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
            columnList.push({"data":null,"defaultContent":
            '<button id="view" class="btn btn-sm btn-primary"><span class="glyphicon glyphicon-eye-open"></span></button>&nbsp;' +
            '<button id="edit" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-edit"></span></button>&nbsp;' +
            '<button id="delete" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-trash"></span></button>'});
            table = $("#tableOutput").DataTable({
            data: returndata,
            columns: columnList,
              "columnDefs": [
                    { "width": 160, "targets": -1 }
                    ]
            });
        });
    return false;
});
});