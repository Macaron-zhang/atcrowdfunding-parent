<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <html lang="zh-CN">
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
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

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="glyphicon glyphicon-th-list"></i> 系统权限菜单
                        <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal">
                        <i class="glyphicon glyphicon-question-sign"></i></div>
                    </div>
                <div class="panel-body">

                    <ul id="treeDemo" class="ztree">

                    </ul>

                </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
                </div>
                <div class="modal-body">
                    <div class="bs-callout bs-callout-info">
                        <h4>没有默认类</h4>
                        <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                    </div>
                    <div class="bs-callout bs-callout-info">
                        <h4>没有默认类</h4>
                        <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                    </div>
                </div>
            <!--
            <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
            </div>
        </div>
    </div>

<%@ include file="/WEB-INF/jsp/common/js.jsp"%>

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
    readyZtree();
});
function readyZtree() {
    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        data: {
            simpleData:{
                enable:true,
                idKey:"id",
                pIdKey:"pid"      //指定后才能显示出结构层次，默认为pId，如果对不上就可以设置这个
            }
        },
        view:{
            addDiyDom:addDivDom,        //添加自定义图标控件
            addHoverDom:addHoverDom,    //添加鼠标移入按钮，弹出按钮组的方法
            removeHoverDom:removeHoverDom   //添加鼠标移出按钮，隐藏按钮组的方法
        }
        <%--async: {--%>
        <%--    enable: true,--%>
        <%--    url: "${PATH}/"--%>
        <%--},--%>
        <%--callback:{--%>

        <%--}--%>
    };
    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
    /*        {name:"test1", open:true,
    children:[ {name:"test1_1"}, {name:"test1_2"}]
    },
    {name:"test2", open:true,
    children:[ {name:"test2_1"}, {name:"test2_2"}]}*/
    var zNodes = [
        // {id:1,pId:0,name:"父节点1",open:true},
        // {id:11,pId:1,name:"子节点1-1"},
        // {id:12,pId:1,name:"父节点1-2"},
        // {id:2,pId:0,name:"父节点2",open:true},
        // {id:21,pId:2,name:"子节点2-1"},
        // {id:22,pId:2,name:"父节点2-2"}

    ];
    $.get("${PATH}/menu/loadTree",{},function(result) {
        // alert("hello");
        zNodes = result;
        // console.log(result);
        var rootNode = {"id":0,"name":"系统权限菜单","icon":"glyphicon glyphicon-th-list"};
        zNodes.push(rootNode);
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");   //获取整棵树
        treeObj.expandAll(true);        //展开整棵树
    });
}

function addDivDom(treeId,treeNode) {       //treeNode 节点的唯一标识 tId；生成规则：setting.treeId + "_" + 内部计数
    $("#"+treeNode.tId+"_ico").removeClass();       //移除原有的图标样式
    $("#"+treeNode.tId+"_span").before('<span class ="'+treeNode.icon+'"></span>');     //新增新的图标样式
}

function addHoverDom(treeId,treeNode) {


}

function removeHoverDom(treeId,treeNode) {


}
    </script>
</body>
</html>

