<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.util.URLManage"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
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
        var manager;
        var sexData = [ { sex: 1, text: '男' }, { sex: 2, text: '女'}, { sex: 0, text: '未知'}];
        pb={
        		manager:null,
        		getCols:function(){
        			return [
        			        { display: '用户编号', name: 'user_id', width: 100, type: 'int' },
        	               { display: '姓名', name: 'nick_name',width: 100, editor: { type: 'text' }},           
        	                { display: '性别', name: 'sex', width: 98, editor: { type: 'select', data: sexData, valueField: 'sex' },  render: function (item)
        	                    {
        	                    for(var the in sexData){
        	                       if(sexData[the]["sex"]==item.sex){
        	                         return sexData[the]['text'];
        	                       }
        	                    } 
        	                    return '未知';               
        	                } },
        	                { display: '用户名称', name: 'user_name',  width: 128, editor: { type: 'text'} },
        	                { display: 'QQ', name: 'qq', width: 128, editor: { type: 'text'} },
        	                //{ display: '生日', name: 'birthday', width: 128, type: "date",format:"yyyy-mm-dd HH:mm:ss",editor: { type: 'date',format: "yyyy-MM-dd"} },
        	                { display: '部门', name: 'department',  width: 100, editor: { type: 'text'} },
        	                { display: '用户等级', name: 'user_rank', align:"right"}
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
        	                enabledEdit: true,isScroll: false,pageSize:18,pageSizeOptions:[10,18,40,50],
        	                data: gridData,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){
        			var doMap={
        					"delete":$pb.grid.getDeleteWhere(pb.manager,"user_id"),
        					"add_data":pb.manager.getAdded(),
        					"up_data":pb.manager.getUpdated()
        			};
        			$pb.DoUrl(manageUrl+"/user/userinfo.do?m=sqlAll",doMap,tiketMap,function(data){
        				if(data.code==0){
        					pb.loadUrlData('');
        				}
        			});
        		},loadUrlData:function(){
        			var url=manageUrl+"/user/userinfo.do?m=get&data=list";
        			var param={add:"order by user_id"};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				var gridData = {Rows:[],Total:0};
        				if(data.code==0){   
        					gridData.Rows=$pb.getColData(data.data,pb.getCols());        					
        					gridData.Total=gridData.Rows.length;
        				}
        				pb.f_initGrid(gridData,"maingrid");	
                    });			
        		}
        };
        $(pb.loadUrlData());
    </script>
</head>
<body  style="padding:0px">
    <div id="maingrid" style="margin-top:5px"></div>
</body>
</html>
