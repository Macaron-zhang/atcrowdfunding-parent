<%--
  Created by IntelliJ IDEA.
  User: 张焕梓
  Date: 2020/8/26
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/jsp/common/css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form" id="addForm" method="post" action="${PATH}/admin/saveAdmin">
                        <div class="form-group">
                            <label for="exampleInputPassword1">登陆账号</label>
                            <input type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入登陆账号" name="loginacct">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword2">用户名称</label>
                            <input type="text" class="form-control" id="exampleInputPassword2" placeholder="请输入用户名称" name="username">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail3">邮箱地址</label>
                            <input type="email" class="form-control" id="exampleInputEmail3" placeholder="请输入邮箱地址" name="email">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button id="addBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
    <%@include file="/WEB-INF/jsp/common/js.jsp"%>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
    
    $("#addBtn").click(function () {
        $("#addForm")[0].submit();
    });
    
    $("#resetBtn").click(function () {
        //  我们通过选择器获取的对象为jquery对象，通过索引，可以将jquery对象转换为dom对象，通过dom对象进行表单重置
        $("#addForm")[0].reset();
    });
</script>
</body>
</html>

