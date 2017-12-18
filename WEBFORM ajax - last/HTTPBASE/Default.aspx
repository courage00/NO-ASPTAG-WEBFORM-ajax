﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HTTPBASE.Default" %>

<% //<head runat="server"><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />%>

<!DOCTYPE html>

<html>
<head>
<title></title>

<meta charset="utf-8" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript">

        $(function () {
            var page = 1,endpage=0 ;
            var queryname = "";
            var querytitle = "";
            //隱藏區塊
            $("#newblock").hide();
            $("#editblock").hide();

            //得到總頁數
            $.ajax({
                type: "POST",
                url: "default.aspx/GetEndpage",
                data: "{'name':'','title':''}",
                contentType: "application/json",
                error: function () {
                    alert("GeteEndpage error");
                },
                success: function (data) {
                    endpage = data.d;
                }
            });
            //得到資料
            $.ajax({
                type: "POST",
                url: "default.aspx/GetData",
                data: "{'page':'" + page + "','name':'','title':''}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function () {
                    alert("GetData erroe");
                },
                success: function (str_json) {
                    var data = JSON.parse(str_json.d);
                    for (var i = 0; i < 5; i++) {
                        $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                            '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                            '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                            '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                            '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                            '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                            '<input type="button" id="edit" value="修改" /><input type="button" id="delete" value="刪除" /></div>' +
                            '</div>');
                    }
                    $("#firstpage").attr("Disabled", "true");
                    $("#lastpage").attr("Disabled", "true");
                }
            });
            //下一頁
            $("#nextpage").click(function () {
                page++;
                $("#firstpage").removeAttr("Disabled");
                $("#lastpage").removeAttr("Disabled");
                if (page == endpage) {
                    $("#nextpage").attr("Disabled", "true");
                    $("#tlastpage").attr("Disabled", "true");
                }
                $(".employee-block").remove();
                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetData",
                    data: "{'page':'" + page + "','name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("GetData by nextpage error");
                    },
                    success: function (str_json) {
                        var data = JSON.parse(str_json.d);
                        var count = 5;
                        if (data.length < 5) {
                            count = data.length;
                        }
                        for (var i = 0; i < count; i++) {
                            $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                                '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                                '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                                '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                                '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                                '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                                '<input type= "button" id= "edit" value= "修改" /><input type="button" id="delete" value="刪除" /></div > ' +
                                '</div>');
                        }
                    }
                });
            });
            //y上一頁
            $("#lastpage").click(function () {
                page--;
                $("#nextpage").removeAttr("Disabled");
                $("#tlastpage").removeAttr("Disabled");
                if (page == 1) {
                    $("#firstpage").attr("Disabled", "true");
                    $("#lastpage").attr("Disabled", "true");
                }
                $(".employee-block").remove();
                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetData",
                    data: "{'page':'" + page + "','name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("GetData by lastpage error");
                    },
                    success: function (str_json) {
                        var data = JSON.parse(str_json.d);
                        for (var i = 0; i < 5; i++) {
                            $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                                '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                                '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                                '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                                '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                                '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                                '<input type="button" id="edit" value="修改" /> <input type="button" id="delete" value="刪除" /></div > ' +
                                '</div>');
                        }
                    }
                });
            });
            //第一頁
            $("#firstpage").click(function () {
                page = 1;
                $("#firstpage").attr("Disabled", "true");
                $("#lastpage").attr("Disabled", "true");
                $("#nextpage").removeAttr("Disabled");
                $("#tlastpage").removeAttr("Disabled");
                $(".employee-block").remove();
                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetData",
                    data: "{'page':'" + page + "','name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("GetData by firstpage error");
                    },
                    success: function (str_json) {
                        var data = JSON.parse(str_json.d);
                        for (var i = 0; i < 5; i++) {
                            $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                                '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                                '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                                '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                                '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                                '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                                '<input type= "button" id= "edit" value= "修改" /><input type="button" id="delete" value="刪除" /></div > ' +
                                '</div>');
                        }
                    }
                });
            });
            //最後一頁
            $("#tlastpage").click(function () {
                page = endpage;
                $("#tlastpage").attr("Disabled", "true");
                $("#nextpage").attr("Disabled", "true");
                $("#lastpage").removeAttr("Disabled");
                $("#firstpage").removeAttr("Disabled");
                $(".employee-block").remove();
                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetData",
                    data: "{'page':'" + page + "','name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("GetData by tlastpage error");
                    },
                    success: function (str_json) {
                        var data = JSON.parse(str_json.d);
                        for (var i = 0; i < data.length; i++) {
                            $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                                '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                                '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                                '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                                '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                                '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                                '<input type= "button" id= "edit" value= "修改" /><input type="button" id="delete" value="刪除" /></div > ' +
                                '</div>');

                        }
                        //alert("1111")
                    }
                });
            });
            //觸發 編輯和刪除
            $('.result').on('click', '#edit', function () {
                var eblock = $(this).closest('.employee-block');
                var emid = eblock.data('id');
                $("#editEmployeeID").val(emid);
               
                $("#editblock").show();

                $.ajax({
                    type: "POST",
                    url: "default.aspx/Edit",
                    data: "{'emid':'" + emid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("Edit error");
                    },
                    success: function (edit_json) {
                        var data = JSON.parse(edit_json.d);
                        $("#editEmployeeName").val(data[0].EmployeeName);
                        $("#editTitle").val(data[0].Title);
                        $("#editTitleOfCourtesy").val(data[0].TitleOfCourtesy);
                        $("#editBirthDate").val(data[0].BirthDate);
                        $("#editHireDate").val(data[0].HireDate);
                        $("#editAddress").val(data[0].Address);
                        $("#editHomePhone").val(data[0].HomePhone);
                        $("#editExtension").val(data[0].Extension);
                        $("#editPhotoPath").val(data[0].PhotoPath);
                        $("#editNotes").val(data[0].Notes);
                        $("#editManagerID").val(data[0].ManagerID);
                        $("#editSalary").val(data[0].Salary);
                    }
                });
            });
            //儲存
            $("#save").on("click", function () {
                //抓出修改id
                var emid = $("#editEmployeeID").val();

                var EmployeeName = $("#editEmployeeName").val();
                var Title = $("#editTitle").val();
                var TitleOfCourtesy = $("#editTitleOfCourtesy").val();
                var BirthDate = $("#editBirthDate").val();
                var HireDate = $("#editHireDate").val();
                var Address = $("#editAddress").val();
                var HomePhone = $("#editHomePhone").val();
                var Extension = $("#editExtension").val();
                var PhotoPath = $("#editPhotoPath").val();
                var Notes = $("#editNotes").val();
                var ManagerID = $("#editManagerID").val();
                var Salary = $("#editSalary").val();

                if (EmployeeName == "") {
                    alert("請輸入EmployeeName");
                }
                else if (Title == "") {
                    alert("請輸入Title");
                }
                else if (TitleOfCourtesy == "") {
                    alert("請輸入TitleOfCourtesy");
                }
                else if (isNaN(Date.parse(BirthDate)) == true) {
                    alert("請輸入正確BirthDate格式");
                }
                else if (isNaN(Date.parse(HireDate)) == true) {
                    alert("請輸入正確HireDate格式");
                }
                else if (Address == "") {
                    alert("請輸入Address");
                }
                else if (HomePhone == "") {
                    alert("請輸入HomePhone");
                }
                else if (Extension == "") {
                    alert("請輸入Extension");
                }
                else if (PhotoPath == "") {
                    alert("請輸入PhotoPath");
                }
                else if (Notes == "") {
                    alert("請輸入Notes");
                }
                else if (isNaN(ManagerID) == true || ManagerID == "") {
                    alert("請輸入ManagerID(數字)");
                }
                else if (isNaN(Salary) == true || Salary == "") {
                    alert("請輸入Salary(數字)");
                }
                else {
                    //alert(emid);
                    $.ajax({
                        type: "POST",
                        url: "default.aspx/SaveEdit",
                        data: "{'id':'" + emid + "','name':'" + EmployeeName + "','title':'" + Title + "','titlec':'" + TitleOfCourtesy + "','bdate':'" + BirthDate + "','hdate':'" + HireDate + "','address':'" + Address + "','hphone':'" + HomePhone + "','ex':'" + Extension + "','photopath':'" + PhotoPath + "','notes':'" + Notes + "','mgid':'" + ManagerID + "','salary':'" + Salary + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        error: function () {
                            alert("SaveEdit error");
                        },
                        success: function () {
                            $("#editEmployeeName").val("");
                            $("#editTitle").val("");
                            $("#editTitleOfCourtesy").val("");
                            $("#editBirthDate").val("");
                            $("#editHireDate").val("");
                            $("#editAddress").val("");
                            $("#editHomePhone").val("");
                            $("#editExtension").val("");
                            $("#editPhotoPath").val("");
                            $("#editNotes").val("");
                            $("#editManagerID").val("");
                            $("#editSalary").val("");

                            $("#editblock").hide();
                            alert("修改成功");
                        }
                    });
                }
            });
            //取消
            $("#cancel").on('click', function () {
                $("#editEmployeeName").val("");
                $("#editTitle").val("");
                $("#editTitleOfCourtesy").val("");
                $("#editBirthDate").val("");
                $("#editHireDate").val("");
                $("#editAddress").val("");
                $("#editHomePhone").val("");
                $("#editExtension").val("");
                $("#editPhotoPath").val("");
                $("#editNotes").val("");
                $("#editManagerID").val("");
                $("#editSalary").val("");

                $("#editblock").hide();
            });
            //刪除
            $(".result").on('click', '#delete', function () {
                var eblock = $(this).closest('.employee-block');
                var delid = eblock.data('id');

                if (confirm("確認刪除?")) {
                    $.ajax({
                        type: "POST",
                        url: "default.aspx/Delete",
                        data: "{'id':'" + delid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        error: function () {
                            alert("Delete error");
                            //alert(delid);
                        },
                        success: function () {
                            eblock.remove();
                            alert("刪除成功");
                        }
                    });
                }
            });

            $("#query").click(function () {
                queryname = $("#querynametext").val();
                querytitle = $("#querytitletext").val();
                page = 1;

                $(".employee-block").remove();

                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetEndpage",
                    data: "{'name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json",
                    error: function () {
                        alert("GetEndpage error");
                    },
                    success: function (data) {
                        endpage = data.d;
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "default.aspx/GetData",
                    data: "{'page':'" + page + "','name':'" + queryname + "','title':'" + querytitle + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function () {
                        alert("GetData by query error");
                    },
                    success: function (str_json) {
                        var data = JSON.parse(str_json.d);
                        var count = 5;
                        if (data.length < 5) {
                            count = data.length;
                        }
                        for (var i = 0; i < count; i++) {
                            $(".result").append('<div class="employee-block" data-id="' + data[i].EmployeeID + '">' +
                                '<div>姓名：<span class="name">' + data[i].EmployeeName + '</span></div>' +
                                '<div>職稱：<span class="title">' + data[i].Title + '</span></div>' +
                                '<div>生日：<span class="date">' + data[i].BirthDate + '</span></div>' +
                                '<div>住址：<span class="address">' + data[i].Address + '</span></div>' +
                                '<div>薪水：<span class="salary">' + data[i].Salary + '</span>' +
                                '<span><input type="button" id="edit" value="修改" /></span> <span><input type="button" id="delete" value="刪除" /></span></div > ' +
                                '</div>');
                        }
                        $("#firstpage").attr("Disabled", "true");
                        $("#lastpage").attr("Disabled", "true");
                        if (endpage == 1) {
                            $("#nextpage").attr("Disabled", "true");
                            $("#tlastpage").attr("Disabled", "true");
                        }
                        else {
                            $("#nextpage").removeAttr("Disabled");
                            $("#tlastpage").removeAttr("Disabled");
                        }
                    }
                });
            });
            
            $("#add").on('click', function () {
                $("#newblock").show();
            });

            $("#new").on("click", function () {
                var EmployeeName = $("#EmployeeName").val();
                var Title = $("#Title").val();
                var TitleOfCourtesy = $("#TitleOfCourtesy").val();
                var BirthDate = $("#BirthDate").val();
                var HireDate = $("#HireDate").val();
                var Address = $("#Address").val();
                var HomePhone = $("#HomePhone").val();
                var Extension = $("#Extension").val();
                var PhotoPath = $("#PhotoPath").val();
                var Notes = $("#Notes").val();
                var ManagerID = $("#ManagerID").val();
                var Salary = $("#Salary").val();

                if (EmployeeName == "") {
                    alert("請輸入EmployeeName");
                }
                else if (Title == "") {
                    alert("請輸入Title");
                }
                else if (TitleOfCourtesy == "") {
                    alert("請輸入TitleOfCourtesy");
                }
                else if (isNaN(Date.parse(BirthDate)) == true) {
                    alert("請輸入正確BirthDate格式");
                }
                else if (isNaN(Date.parse(HireDate)) == true) {
                    alert("請輸入正確HireDate格式");
                }
                else if (Address == "") {
                    alert("請輸入Address");
                }
                else if (HomePhone == "") {
                    alert("請輸入HomePhone");
                }
                else if (Extension == "") {
                    alert("請輸入Extension");
                }
                else if (PhotoPath == "") {
                    alert("請輸入PhotoPath");
                }
                else if (Notes == "") {
                    alert("請輸入Notes");
                }
                else if (isNaN(ManagerID) == true || ManagerID == "") {
                    alert("請輸入ManagerID(數字)");
                }
                else if (isNaN(Salary) == true || Salary == "") {
                    alert("請輸入Salary(數字)");
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "default.aspx/New",
                        data: "{'name':'" + EmployeeName + "','title':'" + Title + "','titlec':'" + TitleOfCourtesy + "','bdate':'" + BirthDate + "','hdate':'" + HireDate + "','address':'" + Address + "','hphone':'" + HomePhone + "','ex':'" + Extension + "','photopath':'" + PhotoPath + "','notes':'" + Notes + "','mgid':'" + ManagerID + "','salary':'" + Salary + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        error: function () {
                            alert("New error");
                        },
                        success: function () {
                            $("#EmployeeName").val("");
                            $("#Title").val("");
                            $("#TitleOfCourtesy").val("");
                            $("#BirthDate").val("");
                            $("#HireDate").val("");
                            $("#Address").val("");
                            $("#HomePhone").val("");
                            $("#Extension").val("");
                            $("#PhotoPath").val("");
                            $("#Notes").val("");
                            $("#ManagerID").val("");
                            $("#Salary").val("");
                            $("#newblock").hide();
                            alert("新增成功");
                        }
                    });
                }
            });

            $("#newcancel").on('click', function () {
                $("#EmployeeName").val("");
                $("#Title").val("");
                $("#TitleOfCourtesy").val("");
                $("#BirthDate").val("");
                $("#HireDate").val("");
                $("#Address").val("");
                $("#HomePhone").val("");
                $("#Extension").val("");
                $("#PhotoPath").val("");
                $("#Notes").val("");
                $("#ManagerID").val("");
                $("#Salary").val("");

                $("#newblock").hide();
            });


        });
    </script>
</head>
<body>
    <div id="newblock">
        <table>
            <tr>
                <th>EmployeeName</th>
                <td>
                    <input name="EmployeeName" type="text" id="EmployeeName" />
                </td>
            </tr>
            <tr>
                <th>Title</th>
                <td>
                    <input name="Title" type="text" id="Title" />
                </td>
            </tr>
            <tr>
                <th>TitleOfCourtesy</th>
                <td>
                    <input name="TitleOfCourtesy" type="text" id="TitleOfCourtesy" />
                </td>
            </tr>
            <tr>
                <th>BirthDate</th>
                <td>
                    <input name="BirthDate" type="text" id="BirthDate" />
                </td>
            </tr>
            <tr>
                <th>HireDate</th>
                <td>
                    <input name="HireDate" type="text" id="HireDate" />
                </td>
            </tr>
            <tr>
                <th>Address</th>
                <td>
                    <input name="Address" type="text" id="Address" />
                </td>
            </tr>
            <tr>
                <th>HomePhone</th>
                <td>
                    <input name="HomePhone" type="text" id="HomePhone" />
                </td>
            </tr>
            <tr>
                <th>Extension</th>
                <td>
                    <input name="Extension" type="text" id="Extension" />
                </td>
            </tr>
            <tr>
                <th>PhotoPath</th>
                <td>
                    <input name="PhotoPath" type="text" id="PhotoPath" />
                </td>
            </tr>
            <tr>
                <th>Notes</th>
                <td>
                    <input name="Notes" type="text" id="Notes" />
                </td>
            </tr>
            <tr>
                <th>ManagerID</th>
                <td>
                    <input name="ManagerID" type="text" id="ManagerID" />
                </td>
            </tr>
            <tr>
                <th>Salary</th>
                <td>
                    <input name="Salary" type="text" id="Salary" />
                </td>
            </tr>

            <tr>
                <th colspan="2" style="text-align: center">
                    <div id="newbuttonfield">
                        <input name="new" type="button" id="new" value="新增" />
                        <input name="newcancel" type="button" id="newcancel" value="取消" />
                    </div>
                </th>
            </tr>
        </table>
    </div>
    <div id="editblock">

        <table>
            <tr>
                <th>EmployeeName</th>
                <td>
                    <input name="editEmployeeID" type="text" style="display:none" id="editEmployeeID" />
                    <input name="editEmployeeName" type="text" id="editEmployeeName" />
                </td>
            </tr>
            <tr>
                <th>Title</th>
                <td>
                    <input name="editTitle" type="text" id="editTitle" />
                </td>
            </tr>
            <tr>
                <th>TitleOfCourtesy</th>
                <td>
                    <input name="editTitleOfCourtesy" type="text" id="editTitleOfCourtesy" />
                </td>
            </tr>
            <tr>
                <th>BirthDate</th>
                <td>
                    <input name="editBirthDate" type="text" id="editBirthDate" />
                </td>
            </tr>
            <tr>
                <th>HireDate</th>
                <td>
                    <input name="editHireDate" type="text" id="editHireDate" />
                </td>
            </tr>
            <tr>
                <th>Address</th>
                <td>
                    <input name="editAddress" type="text" id="editAddress" />
                </td>
            </tr>
            <tr>
                <th>HomePhone</th>
                <td>
                    <input name="editHomePhone" type="text" id="editHomePhone" />
                </td>
            </tr>
            <tr>
                <th>Extension</th>
                <td>
                    <input name="editExtension" type="text" id="editExtension" />
                </td>
            </tr>
            <tr>
                <th>PhotoPath</th>
                <td>
                    <input name="editPhotoPath" type="text" id="editPhotoPath" />
                </td>
            </tr>
            <tr>
                <th>Notes</th>
                <td>
                    <input name="editNotes" type="text" id="editNotes" />
                </td>
            </tr>
            <tr>
                <th>ManagerID</th>
                <td>
                    <input name="editManagerID" type="text" id="editManagerID" />
                </td>
            </tr>
            <tr>
                <th>Salary</th>
                <td>
                    <input name="editSalary" type="text" id="editSalary" />
                </td>
            </tr>

            <tr>
                <th colspan="2" style="text-align: center">
                    <div>
                        <input name="save" type="button" id="save" value="儲存" />
                        <input name="cancel" type="button" id="cancel" value="取消" />
                    </div>
                </th>
            </tr>
        </table>
    </div>

    查詢條件:<br/>

    姓名:<input name="querynametext" type="text" id="querynametext" />
    職稱:<input name="querytitletext" type="text" id="querytitletext" />
    <input name="query" type="button" id="query" value="查詢" />
    <input name="add" type="button" id="add" value="新增" /> <br/>

    <input name="firstpage" type="button" id="firstpage" value="第一頁" />
    <input name="lastpage" type="button" id="lastpage" value="上一頁" />
    <input name="nextpage" type="button" id="nextpage" value="下一頁" />
    <input name="tlastpage" type="button" id="tlastpage" value="最後頁" />
    <div class="result"></div>
 
</body>
</html>
