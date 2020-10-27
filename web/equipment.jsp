<%-- 
    Document   : equipment
    Created on : Oct 22, 2020, 10:45:53 PM
    Author     : demon
--%>

<%@page import="java.util.List"%>
<%@page import="com.model.Equipment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <%
            Equipment equ = new Equipment();
        %>
        <title>Equipment</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script>
            function myLoad(id, name, model, desc, brand, stock, inv, type, fuel, image) {
                $("#txtId").val(id);
                $("#txtName").val(name);
                $("#txtModel").val(model);
                $("#txtDesc").val(desc);
                $("#txtBrand").val(brand);
                $("#numStock").val(stock);
                $("#numInv").val(inv);
                $("#numType").val(type);
                $("#numFuel").val(fuel);
                $("#fileImg").val(image);
            }
        </script>
    </head>
    <body>
        <h1>Equipment CRUD</h1>
        <div class="container">
            <form id="frmMain" action="" method="POST" enctype="multipart/form-data">
                <div class='col-6'>
                    <input type="hidden" name="txtId" id="txtId" class='form-control' value="0"/>
                    <label>Equipment name</label>
                    <input type="text" name="txtName" id="txtName" class='form-control' required/>
                    <label>Model</label>
                    <input type="text" name="txtModel" id="txtModel" class='form-control' required/>
                    <label>Description</label>
                    <textarea class="form-control" name="txtDesc" id="txtDesc" placeholder="Description" required rows="3"></textarea>
                    <label>Brand</label>
                    <input type="text" name="txtBrand" id="txtBrand" class='form-control' required/>
                    <label>In Stock</label>
                    <input type="number" name="numStock" id="numStock" class='form-control' min="0" step="1" required/>
                    <label>Inventory</label>
                    <input type="number" name="numInv" id="numInv" class='form-control' min="1" step="1" required/>
                    <label>Type</label>
                    <input type="number" name="numType" id="numType" class='form-control' min="1" step="1" required/>
                    <label>Fuel rate consumption</label>
                    <input type="number" name="numFuel" id="numFuel" min='0.00' step="0.01" max="100" class='form-control' required/>
                    <label>Image</label>
                    <div class="input-group mb-3">
                        <div class="custom-file">
                          <input type="file" class="custom-file-input" name="fileImg" id="fileImg" aria-describedby="inputGroupFileAddon03">
                          <label class="custom-file-label" for="inputGroupFile03">Choose file</label>
                        </div>
                    </div>
                </div>
                <br>
                <input type="reset" name="btnNew" value="Add/Clear" class="btn btn-outline-info"/>
                <input formaction="equipmentController?btnCreate=y" type="submit" name="btnCreate" id="btnCreate" value="Create" class="btn btn-outline-success"/>
                <input formaction="equipmentController?btnUpdate=y" type="submit" name="btnUpdate" id="btnUpdate" value="Update" class="btn btn-outline-warning"/>
                <input formaction="equipmentController?btnDelete=y" type="submit" name="btnDelete" id="btnDelete" value="Delete" class="btn btn-outline-danger"/>
            </form>

            <table border="1" class=''>
                <tr>
                    <th>Equ id</th>
                    <th>name</th>
                    <th>model</th>
                    <th>description</th>
                    <th>brand</th>
                    <th>stock</th>
                    <th>inventory</th>
                    <th>Type</th>
                    <th>fuel rate</th>
                    <th>picture</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Equipment> lst = equ.showEqu();
                    for (Equipment e : lst) {
                %>
                <tr>
                    <td><%= e.getId()%></td>
                    <td><%= e.getName()%></td>
                    <td><%= e.getModel()%></td>
                    <td><%= e.getDescription()%></td>
                    <td><%= e.getBrand()%></td>
                    <td><%= e.getStock()%> units</td>
                    <td><%= e.getInventory()%> units</td>
                    <td><%= e.getType()%></td>
                    <td><%= e.getFuel_rate()%>%</td>
                    <td><img src="imgs/<%= e.getImage()%>" height="75px" width="100px"></td>
                    <td><a href="javascript:myLoad('<%= e.getId()%>','<%= e.getName()%>','<%= e.getModel()%>',
                           '<%= e.getDescription()%>','<%= e.getBrand()%>','<%= e.getStock()%>','<%= e.getInventory()%>',
                           '<%= e.getType()%>','<%= e.getFuel_rate()%>','<%= e.getImage()%>')">Select</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <br>
            <p>go back to <a href="index.jsp">index</a></p>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body>
</html>