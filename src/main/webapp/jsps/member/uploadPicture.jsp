<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/2
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>center title</title>
</head>
<body>
<div class="row clearfix">
    <div class="col-sm-12 column">
        <div class="row clearfix">
            <%@include file="/common/left.jsp"%>
            <div class="panel panel-default col-sm-9" style="padding-right: 0;padding-left: 0">
                <div class="panel-heading" style="background-color: #337ab7;color:white;">
                    <h3 class="panel-title" >
                        center title
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">商品主图：</label>
                        <div class="item col-sm-6">
                            <img class="icon addImg" onclick="clickImg(this);" src="/updateImg/img/addImg.png">
                            <input type="file" class="upload_input" onchange="change(this)">
                            <div class="preBlock">
                                <img id="goodsMainPhoto" class="preview" alt="" name="pic" width="180" height="180">
                            </div>
                            <img class="delete" onclick="deleteImg(this)" src="/updateImg/img/delete.png">
                        </div>
                        <label class="col-sm-2">
                            <input type="button" class="btn btn-danger" value="上传" id="uploadImage"/>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    /*--------------图片上传--------------*/
    //点击
    var clickImg = function(obj){
        $(obj).parent().find('.upload_input').click();
    }
    //删除
    var deleteImg = function(obj){
        $(obj).parent().find('input').val('');
        $(obj).parent().find('img.preview').attr("src","");
        //IE9以下
        $(obj).parent().find('img.preview').css("filter","");
        $(obj).hide();
        $(obj).parent().find('.addImg').show();
    }
    //选择图片
    function change(file) {
        //预览
        var pic = $(file).parent().find(".preview");
        //添加按钮
        var addImg = $(file).parent().find(".addImg");
        //删除按钮
        var deleteImg = $(file).parent().find(".delete");
        var ext=file.value.substring(file.value.lastIndexOf(".")+1).toLowerCase();

        // gif在IE浏览器暂时无法显示
        if(ext!='png'&&ext!='jpg'&&ext!='jpeg'){
            if (ext != '') {
                alert("图片的格式必须为png或者jpg或者jpeg格式！");
            }
            return;
        }
        //判断IE版本
        var isIE = navigator.userAgent.match(/MSIE/)!= null,
            isIE6 = navigator.userAgent.match(/MSIE 6.0/)!= null;
        isIE10 = navigator.userAgent.match(/MSIE 10.0/)!= null;
        if(isIE && !isIE10) {
            file.select();
            var reallocalpath = document.selection.createRange().text;
            // IE6浏览器设置img的src为本地路径可以直接显示图片
            if (isIE6) {
                pic.attr("src",reallocalpath);
            }else{
                // 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
                pic.css("filter","progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src=\"" + reallocalpath + "\")");
                // 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
                pic.attr('src','data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==');
            }
            addImg.hide();
            deleteImg.show();
        }else {
            html5Reader(file,pic,addImg,deleteImg);
        }
    }
    //H5渲染
    function html5Reader(file,pic,addImg,deleteImg){
        var file = file.files[0];
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(e){
            pic.attr("src",this.result);
        }
        addImg.hide();
        deleteImg.show();
    }
    /* 使用二进制方式处理dataUrl */
    function processData(dataUrl) {
        var binaryString = window.atob(dataUrl.split(',')[1]);
        var arrayBuffer = new ArrayBuffer(binaryString.length);
        var intArray = new Uint8Array(arrayBuffer);
        for (var i = 0, j = binaryString.length; i < j; i++) {
            intArray[i] = binaryString.charCodeAt(i);
        }

        var data = [intArray],
            blob;

        try {
            blob = new Blob(data);
        } catch (e) {
            window.BlobBuilder = window.BlobBuilder ||
                window.WebKitBlobBuilder ||
                window.MozBlobBuilder ||
                window.MSBlobBuilder;
            if (e.name === 'TypeError' && window.BlobBuilder) {
                var builder = new BlobBuilder();
                builder.append(arrayBuffer);
                blob = builder.getBlob(imgType); // imgType为上传文件类型，即 file.type
            } else {
                console.log('版本过低，不支持上传图片');
            }
        }
        return blob;
    }
    //点击上传图片
    $("#uploadImage").click(function () {
        uploadImage();
    });
    function uploadImage() {
        var formData = new FormData();
        var goodsImg=$("#goodsMainPhoto").attr("src");
        if(typeof(goodsImg)=="undefined" ||goodsImg=="" || goodsImg.indexOf("addImg.png")!=-1){
            alert("请选择图片！");
            return;
        }
        var blob1 = processData(goodsImg);
        formData.append('goodsImg', blob1);
        $.ajax({
            type:"post",
            url:"/data/addPicture",
            dataType:"json",
            data:formData,
            processData: false,
            contentType: false,
            success:function(data){
                if(null!=data && data.state){
                    alert("上传成功！")
                    location.href="${pageContext.request.contextPath}/jsps/member/report.jsp"
                }
            }
        });
    }
</script>
</html>
