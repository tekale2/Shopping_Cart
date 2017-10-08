/*global $*/
var veiwStr = '<button id="view" class="btn btn-sm btn-primary"><span class="glyphicon glyphicon-eye-open"></span></button>&nbsp;';
var editStr = '<button id="edit" class="btn btn-sm btn-warning"><span class="glyphicon glyphicon-edit"></span></button>&nbsp;';
var deleteStr = '<button id="delete" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-trash"></span></button>';

var currTableName = "";
function newPage(urlStr)
{
    var actionStr = document.getElementById('editForm').action;
    var custID = actionStr.split("/").pop();
    window.location.href = urlStr+'?id='+custID;
}
function newItemPage(urlStr)
{
    var actionStr = document.getElementById('orderid').innerText;
    var orderID = actionStr.split(":").pop().trim();
    window.location.href = urlStr+'?id='+orderID;
}
function loadTable(urlStr){
var actionStr = document.getElementById('editForm').action;
var custID = actionStr.split("/").pop();
var buttonStr;
 if (urlStr.includes('addresses'))
 {
    buttonStr = "None";
    currTableName = 'addresses';
 }
 else if(urlStr.includes('orders'))
 {
    buttonStr = veiwStr+deleteStr
    currTableName = 'orders';
 }
 else
 {
    buttonStr = editStr+deleteStr;
    currTableName = 'payments';
 }
var dataVal = {name:"customer[id]",value:custID};
    event.preventDefault();
    $.ajax({
        type        : 'POST', // define the type of HTTP verb we want to use (POST for our form)
        url         : urlStr, // the url where we want to POST
        data        :dataVal, // our data object
        dataType    : 'json', // what type of data do we expect back from the server
        encode      : true,
    }).done (function(returndata){
        if ($.fn.DataTable.isDataTable("#tableOutput")) {
          $('#tableOutput').DataTable().clear().destroy();
        }
        $("#tableOutput").empty();
            var keys;
            if(returndata.length >0)
                keys = Object.keys(returndata[0]);
            else
                keys =["ID"];
            var columnList = [];
            for (var i =0;i<keys.length; i++)
            {
                var obj = {};
                obj["data"] = keys[i];
                columnList.push(obj);
            }
            columnList.push({"data":null,"defaultContent":buttonStr});
            var table = $("#tableOutput").DataTable({
            data: returndata,
            columns: columnList,
              "columnDefs": [
                    { "width": 160, "targets": -1 },
                    ]
            });
            var i =0;
            for(i = 0;i<keys.length;i++)
                $( table.column( i ).header() ).text( keys[i].toUpperCase());
             $( table.column( i ).header() ).text('Action');
        $('#tableOutput tbody').on( 'click', 'button', function () {
          var table =  $("#tableOutput").DataTable();
          var tdata = table.row( $(this).parents('tr') ).data();
          var button_id = this.id; 
          if (button_id=='view' || button_id == 'edit'){
              doView(tdata.id,currTableName);
          }
          else if(button_id == 'delete')
          {
              doDelete(tdata.id,currTableName);
              table.row( $(this).parents('tr') ).remove().draw();
          }
          
      } );
        });
}
/*---JQuery Calls---*/
$(document).ready(function() {
    $('#tableOutput').DataTable();
  
    $('#tableOutput tbody').on( 'click', 'button', function () {
      var table =  $("#tableOutput").DataTable();
      var tdata = table.row( $(this).parents('tr') ).data();
      var button_id = this.id; 
      if (button_id=='view' || button_id == 'edit'){
          doView(tdata.id,currTableName);
      }
      else if(button_id == 'delete')
      {
          var val = tdata.id
          if(val == null)
            val = tdata[0];
          doDelete(val,currTableName);
          table.row( $(this).parents('tr') ).remove().draw();
      }
  } );

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
            var keys;
            if(returndata.length >0)
                keys = Object.keys(returndata[0]);
            else
                keys =["ID"];
            var columnList = [];
            for (var i =0;i<keys.length; i++)
            {
                var obj = {};
                obj["data"] = keys[i];
                columnList.push(obj);
            }
            columnList.push({"data":null,"defaultContent": veiwStr+editStr+deleteStr});
            $("#tableOutput").DataTable({
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