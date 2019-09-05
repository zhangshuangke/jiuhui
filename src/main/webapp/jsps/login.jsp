
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <%@include file="/common/header.jsp"%>
<head>
    <link href="/css/login.css" type="text/css" rel="stylesheet">
</head>
<body>
        <p id="user_login" class="yiyouzh">已有账号？<a href="/jsps/login.jsp">请登录&gt;</a></p>
    </div>
</div>
      <div class="car">
             <div  class="car_background">
                        <div class="car_form">
                            <form class="form-horizontal" id="loginForm" method="post" action="/user/loginUser">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-github-alt" aria-hidden="true"></i>
                                        </span>
                                        <input type="text" class="form-control" id="usercode" name="usercode">
                                    </div>
                                    <span class="help-block">&nbsp;</span>
                                </div>
                                <div class="form-group ">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-lock" aria-hidden="true"></i>
                                        </span>
                                        <input type="password" class="form-control" id="password" name="password">
                                    </div>
                                    <span class="help-block">&nbsp;</span>
                                </div>
                            </form>
                            <span style="display: block;height: 30px;"><a href="/jsps/updatePwd.jsp" style="color: white" class="forgetpsw">忘记登录密码?</a><a href="/jsps/register.jsp" style="color: white" class="user_regist">免费注册</a></span>
                            <span style="display: block"><input type="button" id="login_btn" class="btn btn-default" style="width: 100%" value="登&nbsp;&nbsp;陆"></input></span>
                        </div>
             </div>
    </div>
    <%@include file="/common/footer.jsp"%>

</body>

<script type="text/javascript">
    //点击enter登录
    $("body").keydown(function() {
        if (event.keyCode == "13") {//keyCode=13是回车键
            $('#login_btn').click()
        }
    })
    <%--$("#authImg").click(function(){--%>
        <%--$("#authImg").attr("src","${pageContext.request.contextPath}/user/authImage?flag="+Math.random());--%>
    <%--});--%>
    $('#login_btn').on('click', function(){
        var num=0;
        var str="";
        $("input[type$='text'],input[type$='password']").each(function(n){
            if($(this).val()=="")
            {
                layer.alert(str+=""+$(this).attr("name")+"不能为空！\r\n",{
                    title: '提示框',
                    icon:0,
                });
                num++;
                return false;
            }
        });
        if(num>0){  return false;}
        else{
            $.ajax({
                type : "post",
                url : "${pageContext.request.contextPath}/user/login",
                data :$("#loginForm").serialize(),
                dataType : "json",
                error : function(error) {
                    alert('登陆失败！');
                },success : function(data) {
                    if (data.flag) {
                        alert('登陆成功！');
                        location.href = "member/viewData.jsp";
                        layer.close(index);
                    }else{
                        //alert("用户名不存在或密码错误");
                        alert(data.msg);
                    }
                }
            });
        }
    });
    function isError(obj,text){
        obj.parent().parent().removeClass("has-success");
        obj.parent().parent().addClass("has-error");
        obj.parent().next().html(text);
    }
    function isOk(obj,text){
        obj.parent().parent().removeClass("has-error");
        obj.parent().parent().addClass("has-success");
        obj.parent().next().html(text);
    }
    $("#password").blur(function () {
        var password=$("input[type$='password']");
        var pwdReg=/^\w{6,16}$/;
        if(!pwdReg.test(password.val())){
            isError(password,"密码由6-14位的字母、数字和符号组成!")
            return false;
        }isOk(password,"&nbsp;&nbsp;")
    })
</script>
</html>
