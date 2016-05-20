<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath =ItemHelper.getItemUrl();
String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
  <head>
    <title>模板生成</title>	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script src="<%=basePath %>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/manage.js" type="text/javascript"></script>
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
<script type="text/javascript">
   var ticketMap=<%=session.getAttribute("ticketMap")%>;
   var id="<%=id %>";
   function save(){
   		var url=$pb.manageUrl+"/xt/pOpenTree.do?m=update&data=one";
        			var param={id:id,"jspText":$('#temT').val()};
        			$pb.DoUrl(url,param,ticketMap, function(data){
        				if(data.code==0){
        				   alert("保存成功！");
        				}
                    });	
   }
   function bulid(){
        $pb.bulid(id,ticketMap);
   }
   function load(){
   			var url=$pb.manageUrl+"/xt/pOpenTree.do?m=get&data=one";
        			var param={pbCol:"id,jspText",id:id};
        			$pb.DoUrl(url,param,ticketMap, function(data){
        				if(data.code==0){
        				   $('#temT').val(data.data.jspText);
        				}
                    });			
   }
   $(function(){
      load();
   });
</script>
  </head>
  
  <body>
    <textarea id="temT" cols="100" rows="30" style="margin: 0px; width: 766px; height: 453px;"></textarea>
    <br />
    <div style="text-align: center;"><input type="button" onclick="save()" value="保存"/>&nbsp;<input type="button" onclick="bulid()" value="生成" /> </div>
  </body>
</html>
