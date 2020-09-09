<%--
  Created by IntelliJ IDEA.
  User: 张焕梓
  Date: 2020/8/26
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form  id="conditionForm" class="form-inline" role="form" style="float:left;" action="${PATH}/admin/index" method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="conditionLine" class="form-control has-success" type="text" placeholder="请输入查询条件" name="condition" value="${param.condition}">
                            </div>
                        </div>
                        <button id="conditionbtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove" id="batchDelete"></i> 删除</button>
                    <button id="toAddBtn" type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="50">序号</th>
                                <th width="30"><input type="checkbox" class="theadCheckbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageInfo.list}" var="admin" varStatus="status">
                                    <tr>
                                        <%--${status.count}表示每页的显示序号--%>
                                        <td>${status.count}</td>
                                        <td><input type="checkbox" class="itemCheckbox" adminId="${admin.id}"></td>
                                        <td>${admin.loginacct}</td>
                                        <td>${admin.username}</td>
                                        <td>${admin.email}</td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                            <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil" onclick="window.location.href = '${PATH}/admin/toUpdate?id=${admin.id}&pageNum=${pageInfo.pageNum}'" ></i></button>
                                            <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove" class="toDeleteBtn" onclick="doDelete('${admin.id}','${admin.loginacct}')"></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                        <c:if test="${pageInfo.isFirstPage}">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>
                                        <c:if test="${not pageInfo.isFirstPage}">
                                            <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${pageInfo.pageNum-1}">上一页</a></li>
                                        </c:if>

                                        <c:forEach items="${pageInfo.navigatepageNums}" var="navigatepage">
                                            <c:if test="${navigatepage == pageInfo.pageNum}">
                                                <li class="active"><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${navigatepage}">${navigatepage}</a></li>
                                            </c:if>
                                            <c:if test="${navigatepage != pageInfo.pageNum}">
                                                <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${navigatepage}">${navigatepage}</a></li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.isLastPage}">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>
                                        <c:if test="${not pageInfo.isLastPage}">
                                            <li><a href="${PATH}/admin/index?condition=${param.condition}&pageNum=${pageInfo.pageNum+1}">下一页</a></li>
                                        </c:if>

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
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

    $("#conditionbtn").click(function () {
        $("#conditionForm").submit();
    });
    
    <%--$(".toUpdateBtn").click(function () {--%>
    <%--    window.location.href="${PATH}/admin/toUpdate?id=${admin.id}&pageNum=${pageInfo.pageNum}";--%>
    <%--});--%>
    function doDelete(id,loginacct){
        var condition = $("#conditionLine").prop("value");
        layer.confirm("您确定删除【"+loginacct+"】账号吗？",
            {btn:["确认","取消"]},
            function () {
                layer.msg("删除成功！",function () {
                   window.location.href="${PATH}/admin/deleteAdmin?id="+id+"&pageNum=${pageInfo.pageNum}"+"&condition="+condition;
                });
            },
            function () {
                layer.msg("删除取消！");
            }
        );
    }
    //表体的复选框状态 等于 表头的复选框的状态。实现复选框联动效果
    $(".theadCheckbox").click(function () {
        $(".itemCheckbox").prop("checked",this.checked);
    });


    /*批量删除*/
    $("#batchDelete").click(function () {
        var itemCheckedArray = $(".itemCheckbox:checked");  //获取表体勾选的复选框,对象数组
        if(itemCheckedArray.length==0){
            layer.msg("请选择用户后再删除");
            return false;
        }
        var condition = $("#conditionLine").prop("value");
        var idStr='';
        var array = new Array();
        $.each(itemCheckedArray,function (i,e) {    //i 表示索引     e表示当前迭代元素
            //var adminId = e.adminId ; //  e是dom对象。通过dom对象获取自定义属性，无法获取的。
            var adminId = $(e).attr("adminId"); //将dom对象转换为jquery对象，然后，通过attr()函数来获取自定义属性值
            array.push(adminId);
        });

        idStr = array.join(",");        //  '1,2,3,4,5'

        layer.confirm("您确认要删除这些账号吗？",
            {btn:["确认","取消"]},
            function () {
                layer.msg("批量删除成功",function () {
                    window.location.href = "${PATH}/admin/deleteBatchAdmin?id="+idStr+"&pageNum=${pageInfo.pageNum}"+"&condition="+condition;
                });
            },
            function () {
                layer.msg("批量删除取消");
            }
        );
    });

</script>
</body>
</html>

