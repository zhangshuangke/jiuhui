<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/2
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>录入活动数据</title>
</head>
<body>
<div class="row clearfix">
    <div class="col-sm-12 column">
        <div class="row clearfix">
            <%@include file="/common/left.jsp"%>
            <div class="panel panel-default col-sm-9" style="padding-right: 0;padding-left: 0">
                <div class="panel-heading" style="background-color: #337ab7;color:white;">
                    <h3 class="panel-title" >
                        录入活动数据
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" id="active_form">
                        <div class="form-group">
                            <label class="col-sm-1 columns">计划名称:</label>
                            <div class="col-sm-3">
                                <strong>${param.name}</strong>
                                <input type="hidden" value="${param.id}" name="forecastId">
                                <input type="hidden" value="${user.id}" name="userId">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">实际桌数:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="actualNum" name="actualNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">新客户:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="newClient" name="newClient">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">旧客户:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="oldClient" name="oldClient">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">意向客户:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="potentialClient" name="potentialClient">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">保费:</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="money" name="money">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 columns">活动时间:</label>
                            <div class="col-sm-3">
                                <input type="date" class="form-control" id="activityTime" name="activityTime">
                            </div>
                        </div>
                    </form>
                        <div class="form-group" style="padding-left: 100px">
                            <input type="submit" id="add_btn"  class="btn btn-primary" value="提交">
                            <button type="button" class="btn btn-default"   data-dismiss="modal">取消
                            </button>
                        </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $("#add_btn").click(function () {
        $.ajax({
            url:'${pageContext.request.contextPath}/data/addActiveData',
            type:'post',
            data:$("#active_form").serialize(),
            dataType:'json',
            success:function(data){
                    alert("添加成功！");
                    location.href="${pageContext.request.contextPath}/jsps/member/uploadPicture.jsp"
            }
        });
    })
</script>
</html>
