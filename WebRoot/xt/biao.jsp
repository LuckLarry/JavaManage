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
                        cols:[{"isSort":"false","align":"left","width":100,"name":"pFid","display":"序号"},{"isSort":"false","align":"left","width":100,"name":"pTName","display":"表名字"},{"isSort":"false","align":"left","width":100,"name":"pTField","display":"字段名称"},{"isSort":"false","align":"left","width":100,"name":"pTFDes","display":"字段描述"},{"isSort":"false","align":"left","width":100,"name":"pTDValue","display":"初始值"}],
refField:{pTName:{editor:{type:'text'}},
pTField:{editor:{type:'text'}}
},
        		getCols:function(d_){
        		   if(d_){
        		      for(var r_ in pb.refField){        		      
        		       for(var c_ in pb.cols){
        		           if(pb.cols[c_]['name']==r_){
        		              pb.cols[c_]['render']=pb.refField[r_]['render'];
        		              pb.cols[c_]['editor']=pb.refField[r_]['editor'];
                                      pb.cols[c_]['value']=pb.refField[r_]['value'];
        		              break;
        		           }
        		       } 
        		      }     		    
        			}
return pb.cols;
        		},addNewRow:function(){
        		    if(pb.initValue==null){
	        		  pb.initValue=$pb.grid.initRow(pb.getCols());
        		    }
        		    pb.manager.addRow(pb.initValue);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},f_initGrid:function(gridData,gridId){
        			var gridInfo={
        	                columns:pb.getCols(true) ,
        					 toolbar: { items: [
	        	                { text: '增加', click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: '删除', click: pb.deleteRow, img: '<%=basePath%>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
	        	                { line: true },
	        	                { text: '保存', click: pb.saveAll, icon: 'modify' }
	        	                ]
        	                },
        	                enabledEdit: true,isScroll: false,pageSize:19,pageSizeOptions:[10,19,40,50],
        	                data: gridData,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){
$pb.Data.gridSave(pb.manager,tiketMap,20,"id",'');
        		},loadUrlData:function(){
      $pb.Data.load({},tiketMap,20,$pb.grid.pbCol(pb.cols),function(data){
       				if(data.code==0){
       				        gridData=$pb.Data.toGrid(data.data);       				   
       					pb.f_initGrid(gridData,"maingrid");
       				}else{
                                           gridData=$pb.Data.toGrid([]);   
                                          pb.f_initGrid(gridData,"maingrid");
                                }
      });	
       } };
        $(function(){
        	pb.loadUrlData();
       });
    </script>
</head>
<body  style="padding:0px">
   表名称：<input type="text" value="" id="TB"/>
    <div id="maingrid" style="margin-top:5px"></div>
</body>
</html>
