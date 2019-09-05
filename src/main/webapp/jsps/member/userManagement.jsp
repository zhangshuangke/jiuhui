<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/29
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <style type="text/css">
        .ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
    </style>
</head>
<body>
<div class="row clearfix">
    <div class="col-sm-12 column">
        <div class="row clearfix">
            <%@include file="/common/left.jsp"%>
            <div class="panel panel-default col-sm-9" style="padding-right: 0;padding-left: 0">
                <div class="panel-heading" style="background-color: #337ab7;color:white;">
                    <h3 class="panel-title" >
                        用户管理
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="col-sm-3 column">
                        <div >
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </div>
                    <div class="col-sm-9 column">
                        <table id="tab"></table>
                        <input type="hidden" id="tab_id">
                        <button id="add_btn" class="btn btn-primary">添加</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-body">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        展示页面
                    </h4>
                </div>
                <!-- 模态框展示 -->
                <p>
                <form class="form-horizontal" id="f2" role="form">
                    <input type="hidden" class="form-control" name="pId" id="area_pid">
                    <div class="form-group">
                        <label for="name"  class="col-sm-2 control-label">名称</label>
                        <div id="div0" class="col-sm-5">
                            <input type="text" class="form-control" id="name" name="name">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <input type="button" value="提交"  id="sb1" class="btn btn-primary">
            </div>
        </div>
    </div>
</div>
<!-- 模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-body">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">
                        展示页面
                    </h4>
                </div>
                <!-- 模态框展示 -->
                <p>
                <form class="form-horizontal" id="f3" role="form">
                    <input type="hidden" class="form-control" id="user_pid" name="pId">
                    <div class="form-group">
                        <label for="name"  class="col-sm-2 control-label">用户名称:</label>
                        <div class="col-sm-5">
                            <input type="text" id="user_name" class="form-control" name="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="usercode"  class="col-sm-2 control-label">code描述:</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="usercode" name="usercode">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password"  class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-5">
                            <input type="password" id="password" class="form-control" name="password">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <input type="button" value="提交"  id="sb2" class="btn btn-primary">
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function(){
        $("#tab").bootstrapTable({
            url:'${pageContext.request.contextPath}/tree/findAreaAll',
            method:'post',//提交方式
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",//发送到服务器的编码类型
            striped:true,
            pageNumber:1,
            pageSize:8,
            pageList:[6,7,8],
            pagination:true,//开启分页
            sidePagination:"client",//分页方式 'client'为客户端分页
            sortName:'id',//排序需要的属性
            sortOrder:'asc',//排序方式
            cache:false,//是否使用缓存
            //showColumns:true,
            queryParams:function(param){//请求参数 封装的表格对象
                return{
                    id:$("#tab_id").val()
                }
            },
            columns:[
                {
                    title:'序号',//表头名
                    formatter :function (value,row,index){
                        return index+1;
                    }
                },{
                    field:'name',
                    title:'名称'
                },{
                    field:'usercode',
                    title:'code信息'
                },{
                    field:'level',
                    title:'级别'
                },{
                    title:'操作',
                    formatter :function (value,row,index){
                        return "<a href='javascript("+row.id+")'>删除</a>"+
                            "<a>更改</a>";
                    }
                }
            ]
        });
    });
    var setting = {
        data: {
           simpleData: {
            enable: true,
        }
        },
        view:{
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
        },edit:{
            enable:true
        },callback: {
            beforeRemove: zTreeBeforeRemove,//删除之前
            onRename: zTreeOnRename,
            onClick: zTreeOnClick//点击事件
        }
    };

    //点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        $("#tab_id").val(treeNode.id);
        $("#tab").bootstrapTable('refresh');

    }
    //隐藏添加按钮
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };
    //添加按钮
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
            + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            addNodes(treeId, treeNode);
        });
    }
    //修改
    function zTreeOnRename(event, treeId, treeNode, isCancel) {
        var name=treeNode.name;
        var id=treeNode.id;
        $.ajax({
            url:'${pageContext.request.contextPath}/tree/update',
            type:'post',
            data:{name:name,id:id},
            dataType:'json',
            success:function(data){
                if(data){
                    alert("修改成功！");
                    //刷新
                    initTree();
                }
            }
        });
    }
    //删除
    function zTreeBeforeRemove(treeId, treeNode,str) {
        //var msg=confirm("确认删除？");
        var str='';
        str=getChildrenNodes(treeNode,str);
        str+=","+treeNode.id;
        //去掉逗号
        var id=str.substring(1,str.length);//从1开始,在总长之前结束
        var ids=id.split(",");//分割成数组
        if(treeNode.pId==0){
            alert("根节点不能删除！");
            return false;
        }else{
            deleteTree(ids);
        }
    }
    //获取子节点
    function getChildrenNodes(treeNode,result){
        if(treeNode.isParent){
            var child=treeNode.children;
            if(child){
                for(var i=0;i<child.length;i++){
                    result+=","+child[i].id;
                    result=getChildrenNodes(child[i],result);
                }
            }
        }
        return result;
    }
    function deleteTree(ids){
        $.ajax({
            url:'${pageContext.request.contextPath}/tree/delete',
            type:'post',
            data:{ids:ids},
            async:false,
            traditional:true,
            success:function(data){
                if(data){
                    alert("删除成功！");
                    return true;
                    //刷新
                    initTree();
                }
            }
        });
    }
    //添加操作
    function addNodes(treeId, treeNode){
        $("#myModal").modal('show');
        //ajax
        $("#sb1").click(function(){
            $("input[name=pId]").val(treeNode.id);
            $.ajax({
                url:'${pageContext.request.contextPath}/tree/add',
                type:'post',
                data:$("#f2").serialize(),
                dataType:'json',
                success:function(data){
                    $("#myModal").modal('hide');
                    alert("添加成功！");
                    //刷新
                    initTree();
                },error:function(data){
                    alert("失败！");
                }
            });
        });
    }
    var zNodes=[];
    //回调函数
    $(function(){
      $.ajax({
            url:'${pageContext.request.contextPath}/tree/findAll',
            type:'post',
            data:{},
            dataType:'json',
            success:function(data){
                zNodes=data;
                initTree();
            }
        });

    });


    //刷新树
    function initTree(){
        $.fn.zTree.init($("#treeDemo"), setting,zNodes);//初始化树
    }

    $("#add_btn").click(function () {
        var id=$("#tab_id").val();
        if(id==null || id==""){
            alert("请先选择节点！")
            return false;
        }else{
            $("#addModal").modal('show');
            $("#user_pid").val(id)
        }
    })
    $("#sb2").click(function () {
        $.ajax({
            url:'${pageContext.request.contextPath}/tree/addUser',
            type:'post',
            data:$("#f3").serialize(),
            dataType:'json',
            success:function(data){
                $("#addModal").modal('hide');
                alert("添加成功！")
                $("#tab").bootstrapTable("refresh");

            }
        });
        var pId=$("#user_pid").val();
        var name=$("#user_name").val();
        $("#area_pid").val(pId)
        $("#name").val(name)
        $.ajax({
            url:'${pageContext.request.contextPath}/tree/add',
            type:'post',
            data:$("#f2").serialize(),
            dataType:'json',
            success:function(data){
               initTree();
            }
        });
    })
</script>
</html>
