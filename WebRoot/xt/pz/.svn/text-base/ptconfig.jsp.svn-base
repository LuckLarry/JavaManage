<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.util.URLManage"%>
<%
String path = request.getContextPath();
String basePath =ItemHelper.getItemUrl();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="<%=basePath %>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>/js/Source/lib/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />

    <script src="<%=basePath %>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/json2.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
     <link href="<%=basePath %>/js/Source/lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>

<script src="<%=basePath %>/js/manage.js" type="text/javascript"></script>
    <script type="text/javascript"> 
        var tiketMap=<%=session.getAttribute("tiketMap")%>;
        var manageUrl="<%=URLManage.getConfigUrl(true).get("manage") %>";
        pb={
        		manager:null,
        		getCols:function(){
        			return [
	                            { display: '主键', name: 'id', width: 50, type: 'int',hide:false,value:"0" },
	                            { display: '域名', name: 'pt_url',align:"left",editor: { type: 'text' },value:"http://"},           
	                            { display: '备注', name: 'pt_des', width: 200, editor: { type: 'text'},value:"" },
	                            { display: '平台别名', name: 'pt_alias', type: 'text', width: 100, editor: { type: 'text'},value:"" }
                            ];
        		},addNewRow:function(){
        			var l=pb.getCols();
        			var fM={};
        			var m;
        			for(var i in l){
        				m=l[i];
        				fM[m['name']]=m['value'];
        			}
        			pb.manager.addRow(fM);
        		},deleteRow:function(){
        			pb.manager.deleteSelectedRow();
        		},f_initGrid:function(gridData,gridId){
        			var gridInfo={
        	                columns:pb.getCols() ,
        					 toolbar: { items: [
	        	                { text: '增加', click: pb.addNewRow, icon: 'add' },
	        	                { line: true },
	        	                { text: '删除', click: pb.deleteRow, img: '<%=basePath %>/js/Source/lib/ligerUI/skins/icons/delete.gif' },
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
        			var doMap={
        					"delete":$pb.grid.getDeleteWhere(pb.manager,"id"),
        					"add_data":pb.manager.getAdded(),
        					"up_data":pb.manager.getUpdated()
        			};
        			$pb.DoUrl(manageUrl+"/pturl.do?m=sqlAll",doMap,tiketMap,function(data){
        				if(data.code==0){       				
        					pb.loadUrlData();
        				}
        			});
        		},loadUrlData:function(){
        			var url=manageUrl+"/pturl.do?m=get&data=list";
        			var param={add:"order by id"};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				var gridData = {Rows:[],Total:0};
        				if(data.code==0){
        					gridData.Rows=data.data;
        					gridData.Total=gridData.Rows.length;
        					pb.manager.loadData(gridData);
        				}
                    });			
        		}
        };
        $(function(){
        	pb.f_initGrid("","maingrid");
        	pb.loadUrlData();
       });
    </script>
</head>
<body  style="padding:0px">
    <div id="maingrid" style="margin-top:5px"></div>
</body>
</html>

