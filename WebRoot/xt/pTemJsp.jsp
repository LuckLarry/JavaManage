<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%
    String path = request.getContextPath();
    String basePath =ItemHelper.getItemUrl();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<link href="<%=basePath%>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>/js/Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/json2.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
<link href="<%=basePath%>/js/Source/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script> 
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script> 
<script src="<%=basePath%>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/manage.js" type="text/javascript"></script>
    <script type="text/javascript"> 
        var tiketMap=<%=session.getAttribute("ticketMap")%>;
        var manageUrl=$pb.manageUrl;
        pb={
        		manager:null,
        		initValue:null,
        		getCols:function(){
        			return [
{"align":"left","width":40,"name":"id","display":"序号"},
{"editor":{"type":"text"},"align":"left","width":100,"name":"temName","display":"模板名称"},
{"editor":{"type":"text"},"align":"left","width":50,"name":"type","display":"类型",value:"内容"},
{"editor":{"type":"text"},"align":"left","width":200,"name":"temDes","display":"备注"},
{ display: '操作', isSort: false, width: 120, render: function (rowdata, rowindex, value)
                {
                    var h = "";
                        h += "<a href='javascript:pb.show(" + rowdata.id + ")'>查看</a> ";                       
                    return h;
                }}];
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        			pb.initValue=$pb.grid.initRow(pb.getCols());
        			}
        			pb.manager.addRow(pb.initValue);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},f_initGrid:function(gridData,gridId){
        			var gridInfo={
        	                columns:pb.getCols() ,
        					 toolbar: { items: [
	        	                { text: '增加', click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: '删除', click: pb.deleteRow, img: '<%=basePath%>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
	        	                { line: true },
	        	                { text: '保存', click: pb.saveAll, icon: 'modify' }
	        	                ]
        	                },
        	                enabledEdit: true,isScroll: false,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,detailHeight:60,rowHeight:23,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){
        			var doMap={
        					"delete":$pb.grid.getDeleteWhere(pb.manager,"id"),
        					"add_data":pb.manager.getAdded(),
        					"up_data":pb.manager.getUpdated()
        			};var saveing= $.ligerDialog.waitting('正在保存，请稍等.....');
        			$pb.DoUrl(manageUrl+"/xt/pTemJsp.do?m=sqlAll",doMap,tiketMap,function(data){
        				if(data.code==0){       				
        					location.reload();
        				}else{
                                          setTimeout(function (){
		                                saveing.close();
		                          }, 1000);
                                        }
        			});
        		},loadUrlData:function(){
        			var url=manageUrl+"/xt/pTemJsp.do?m=get&data=list";
        			var param={pbCol:"id,temName,temDes,type"};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				var gridData = {Rows:[],Total:0};
        				if(data.code==0){
        					gridData.Rows=data.data;
        					gridData.Total=gridData.Rows.length;
        					pb.f_initGrid(gridData,"maingrid");
        				}
                    });			
        		},show:function(no){
	        		var url=manageUrl+"/xt/pTemJsp.do?m=get&data=one";
	        		var param={pbCol:"id,temText",id:no};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        					pb.theTem.temId=no;
        				    $('#temT').val(data.data.temText);
        					pb.theTem.temDiv=$.ligerDialog.open({
		        			   width:880,
		        			   height:600,
				               target: $("#target1")	                
            				});
        				}
                    });
        		},theTem:{
        		   temDiv:null,
        		   temId:null
        		},save:function(){
        		   	var url=$pb.manageUrl+"/xt/pTemJsp.do?m=update&data=one";
        			var param={id:this.theTem.temId,"temText":$('#temT').val()};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				   alert("保存成功！");
        				}
                    });	
        		} 
        };
        $(function(){
        	pb.loadUrlData();
       });
    </script>
</head>
<body  style="padding:0px">
    <div id="maingrid" style="margin-top:5px"></div>
<div id="target1" style="display:none;">
    <textarea id="temT" cols="100" rows="30" style="margin: 0px; width: 850px; height: 453px;"></textarea>
    <br />
    <div style="text-align: center;"><input type="button" onclick="pb.save()" value="保存"/></div>
 </div>
</body>
</html>
