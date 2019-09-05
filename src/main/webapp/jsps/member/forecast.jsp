<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/2
  Time: 8:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预报数据</title>
</head>
<body>
<div class="row clearfix">
    <div class="col-sm-12 column">
        <div class="row clearfix">
            <%@include file="/common/left.jsp"%>
            <div class="panel panel-default col-sm-9" style="padding-right: 0;padding-left: 0">
                <div class="panel-heading" style="background-color: #337ab7;color:white;">
                    <h3 class="panel-title" >
                        预报数据————提交计划
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" id="plan_form">
                        <div class="form-group">
                            <label class="col-sm-1 columns">计划名称:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="planName" name="planName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">计划桌数:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="planTable" name="planTable">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">开始时间:</label>
                            <div class="col-sm-3">
                                <input type="date" class="form-control" id="begintime" name="begintime">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">结束时间:</label>
                            <div class="col-sm-3">
                                <input type="date" class="form-control" id="endtime" name="endtime">
                            </div>
                        </div>
                        <div class="form-group" style="padding-left: 100px">
                          <input type="submit" id="plan_btn"  class="btn btn-primary" value="提交">
                            <button type="button" class="btn btn-default"   data-dismiss="modal">取消
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $("#plan_btn").click(function () {
        $.ajax({
            url:'${pageContext.request.contextPath}/data/addPlan',
            type:'post',
            data:$("#plan_form").serialize(),
            dataType:'json',
            success:function(data){
                if(data){
                    alert("添加成功！");
                }
            }
        });
    })
</script>
</html>
