<%--
  Created by IntelliJ IDEA.
  User: 张焕梓
  Date: 2020/8/27
  Time: 20:49
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
                    <form class="form-inline" role="form" style="float:left;" id="searchForm">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="searchLine" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" id="searchBtn"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" id="toAddRoleBtn"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="40">序号</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>

                            <tbody>

                            </tbody>

                            <tfoot>
<%--                            <tr >--%>
<%--                                <td colspan="6" align="center">--%>
<%--                                    <ul class="pagination">--%>
<%--                                        <li class="disabled"><a href="#">上一页</a></li>--%>
<%--                                        <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>--%>
<%--                                        <li><a href="#">2</a></li>--%>
<%--                                        <li><a href="#">3</a></li>--%>
<%--                                        <li><a href="#">4</a></li>--%>
<%--                                        <li><a href="#">5</a></li>--%>
<%--                                        <li><a href="#">下一页</a></li>--%>
<%--                                    </ul>--%>
<%--                                </td>--%>
<%--                            </tr>--%>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--添加Role的模态框部分--%>
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加角色</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form id="addForm">
                            <div class="form-group">
                                <label for="roleName">角色名称</label>
                                <input type="text" class="form-control" id="roleName" placeholder="请输入角色名称" name="name">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="addCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="addRoleBtn">新增</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--修改Role的模态框部分--%>
<div class="modal fade" id="updateModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改角色</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form id="updateForm">
                            <div class="form-group">
                                <label for="roleName">角色名称</label>
                                <input type="hidden" name="id" id="updateRoleId"/>
                                <input type="text" class="form-control" id="updateRoleName" placeholder="请输入角色名称" name="name">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="updateCancelBtn">取消</button>
                <button type="button" class="btn btn-primary" id="updateRoleBtn">修改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


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
        showData(1);
    });

    var json={
      pageNum:1,
      pageSize:2
    };

    //异步显示页面，加载数据，进行局部刷新
    function showData(pageNum) {
        json.pageNum = pageNum;
        $.ajax({
            type:"post",
            data:json,
            url:"${PATH}/role/loadData",
            success:function (result) {     // PageInfo<TRole>  ==>>>  json
                console.log(result);        //将返回的数据打印在浏览器控制台
                json.pages = result.pages;  //总页码数
                //定义两个函数，一个显示tbody的页面数据
                showTable(result.list); //要将返回的分页的对象的list对象取出来赋值
                //一个显示导航条
                showNavg(result);
            }
        });
        //显示页面数据
        function showTable(list) {
            var table = ''; //定义一个空的串，往里面拼接HTML代码
            $.each(list,function (i,e) {
                table += '<tr>';
                table += '	<td>'+(i+1)+'</td>';
                table += '	<td><input type="checkbox"></td>';
                table += '	<td>'+e.name+'</td>';
                table += '	<td>';
                table += '		<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                table += '		<button roleId="'+e.id+'" type="button" class="btn btn-primary btn-xs" class="updateBtn"><i class=" glyphicon glyphicon-pencil"></i></button>';
                table += '		<button onclick="deleteRoleById('+e.id+',\''+e.name+'\')" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                table += '	</td>';
                table += '</tr>';
            });
            $("tbody").html(table);     //往tbody标签里填Html代码
        }
        //显示导航条
        function showNavg(result) {
            var navigate = '';  //定义一个空的串，往里面拼接HTML代码

            navigate+='<tr >';
            navigate+='	<td colspan="6" align="center">';
            navigate+='		<ul class="pagination">';

            if(result.isFirstPage) {
                navigate += '<li class="disabled"><a href="#">上一页</a></li>';
            }else {
                navigate += '<li><a onclick="showData('+(result.pageNum-1)+')">上一页</a></li>';
            }

            // navigate += '			<li><a href="#">2</a></li>';
            $.each(result.navigatepageNums,function (i, e) {
                if(result.pageNum==e){
                    navigate += '<li class="active"><a onclick="showData(e)">'+e+'</a></li>';
                }else{
                    navigate += '<li><a onclick="showData('+ e +')">'+ e +'</a></li>';
                }
            });
            if(result.isLastPage) {
                navigate += '<li class="disabled"><a href="#">下一页</a></li>';
            }else{
                navigate += '<li><a onclick="showData('+(result.pageNum+1)+')">下一页</a></li>';
            }

            navigate+='		</ul>';
            navigate+='	</td>';
            navigate+='</tr>';

            $("tfoot").html(navigate);  //往tfoot标签里填Html代码
        }

    }

    //==========================按条件分页查=================================
    $("#searchBtn").click(function () {
        var condition = $("#searchLine").val();
        json.condition = condition;
        // $("#searchForm").commit();
        showData(1);        //一showData，就会异步获取数据，从json中把条件拿走，返回一个PageInfo的结果
    });

    //=========================新增Role========================================
    $("#toAddRoleBtn").click(function () {
        //弹出模态框
        $("#addModal").modal({
            show:true,      //是否模态框一初始化好了就弹出显示？默认为true
            backdrop:'static',      //将模态框设置为静态的，不会因为鼠标点击其它地方而退出模态框
            keyboard:false      //是否esc键退出模态框？默认为true
        })
    });
    
    $("#addRoleBtn").click(function () {
        //1.获取表单数据
        var name = $("#roleName").val();
        //2.发起ajax请求保存数据
        var url = "${PATH}/role/addRole";
        var data = {name:name};
        $.post(url,data,function (result) {
            console.log(result);
            //3.关闭模态框
            $("#addModal").modal('hide');
            $("#roleName").val('');
            if(result =='ok'){
                layer.msg("添加成功");
                //查询数据，显示最新的数据---去最后一页
                showData(json.pages+1);     //防止出现新数据在下一页的情况
            }else {
                layer.msg("添加失败");
            }
        });
    });

    //=================修改某个角色的信息==========================
    //后刷新到页面的元素不能直接使用click()来绑定事件的。不起作用。
    /*$(".updateBtnClass").click(function(){ //页面原来就存在的元素，可以用click函数直接绑定事件。
        alert("ok");
    });*/
    $("tbody").on("click",".updateBtn",function () {
        //回显要修改的角色的名字
        var roleId = $(this).attr("roleId");
        $.post("${PATH}/role/toUpdate",{id:roleId},function (result) {
            $("#updateRoleId").val(result.id);
            $("#updateRoleName").val(result.name);
        });
        //修改,弹出模态框
        $("#updateModal").modal({
            show:true,      //是否模态框一初始化好了就弹出显示？默认为true
            backdrop:'static',      //将模态框设置为静态的，不会因为鼠标点击其它地方而退出模态框
            keyboard:false      //是否esc键退出模态框？默认为true
        });
       

    });
    $("#updateRoleBtn").click(function () {
        //1.获取表单数据
       var id = $("#updateRoleId").val();
       var name = $("#updateRoleName").val();
        //2.提交ajax请求，修改数据库数据
       $.post("${PATH}/role/updateRoleById",{id:id,name:name},function (result) {
           if(result == "ok"){
               layer.msg("修改成功");
               //3.关闭模态框
               $("#updateModal").modal('hide');
               // $("#updateRoleName").val('');
               //4.重新查询数据，显示最新修改内容
                showData(json.pageNum); //回到当前页
           }else{
                layer.msg("修改失败");
           }
       })
    });
    
    //=================删除某个角色通过id========================
    function deleteRoleById(id, name) {
        layer.confirm("您确定要删除【"+name+"】角色吗？",{btn:["确认","取消"]},function () {
            layer.msg("确认删除",function () {
                $.post("${PATH}/role/deleteRoleById",{id:id},function (result) {
                    if(result == "ok"){
                        layer.msg("删除成功",{time:1000},function () {
                            showData(json.pageNum);
                        });

                    }else {
                        layer.msg("删除失败");
                    }
                });
            })
        },function () {
            layer.msg("取消删除");
        });
    }
</script>
</body>
</html>

