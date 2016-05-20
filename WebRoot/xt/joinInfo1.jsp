<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
                        cols:[{"isSort":"false","align":"left","width":100,"name":"id","display":"序号"},{"isSort":"false","align":"left","width":100,"name":"urlId","display":"urlId"},{"isSort":"false","align":"left","width":100,"name":"urlJoinTable","display":"没用参数"},{"isSort":"false","align":"left","width":300,"name":"tableAlias","display":"连表信息"},{"isSort":"false","align":"left","width":100,"name":"actionDo","display":"do请求",value:"/xt/man.do"},{"isSort":"false","align":"left","width":100,"name":"actionTable","display":"请求表"},{"isSort":"false","align":"left","width":100,"name":"temId","display":"模板页Id"},
			{ display: '重改参数', isSort: false, width: 120, render: function (rowdata, rowindex, value){
			var h = "";
			h += "<a href='javascript:pb.show(" + rowdata.id + ")'>查看</a> "; 
			h += "<a href='javascript:pb.bulid(" + rowdata.id + ")'>生成</a> "; 
			 return h;
			}}],
			refField:{
			   urlid:{editor:{type:"text"}},
			   tableAlias:{editor:{type:"text"}},
			   actionTable:{editor:{type:"text"}},
			   actionDo:{editor:{type:"text"}},
			   temId:{editor:{type:"text"}}
			},
        		getCols:function(d_){
        		   if(d_){
        		      for(var r_ in pb.refField){        		      
        		       for(var c_ in pb.cols){
        		           if(pb.cols[c_]['name']==r_){
        		              pb.cols[c_]['render']=pb.refField[r_]['render'];
        		              pb.cols[c_]['editor']=pb.refField[r_]['editor'];
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
        	                data: gridData,detailHeight:60,rowHeight:80,
        	                width: '98%' 
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){
        			var doMap={
                                                "pb_UrlId":14,
        					"delete":$pb.grid.getDeleteWhere(pb.manager,"id"),
        					"add_data":pb.manager.getAdded(),
        					"up_data":pb.manager.getUpdated()
        			};
        			$pb.DoUrl(manageUrl+"/xt/man.do?m=sqlAll",doMap,tiketMap,function(data){
        				if(data.code==0){       				
        					pb.loadUrlData();
        				}
        			});
        		},show:function(no){
        		   	var url=$pb.manageUrl+"/xt/man.do?m=get&data=one";
        			var param={pbCol:"id,pbRefParam",id:no,"pb_UrlId":14};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        					pb.theTem.temId=no;
        				    $('#temT').val(data.data.jspText);
                            pb.showTemButton();
        					pb.theTem.temDiv=$.ligerDialog.open({
		        			   width:880,
		        			   height:600,
				               target: $("#target1")
            				});
            			}
            		});
        		},bulid:function(no){
        			if(!no){
        			  no=pb.theTem.temId; 
        			}
        		    $pb.bulid(no,tiketMap);
        		},save:function(){
        		   	var url=$pb.manageUrl+"/xt/man.do?m=update&data=one";
        			var param={id:this.theTem.temId,"pbRefParam":$('#temT').val() , "pb_UrlId":14};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				  	$.ligerDialog.waitting('保存成功！');
		                          setTimeout(function ()
		                          {
		                         $.ligerDialog.closeWaitting();
		                          }, 1000);
                                  pb.showTemButton();
        				}
                    });
        		},imporTem:function(){
        		    var url=$pb.manageUrl+"/xt/pOpenTree.do?m=imp&id="+this.theTem.temId;
        			var param={};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				    $('#temT').val(data.data.jspText);
                            pb.showTemButton();
        				}
                    });	
        		},theTem:{
        		   temDiv:null,
        		   temId:null
        		},showTemButton:function(){
       				var temText=$('#temT').val();
     				if(temText==""){
     				    $("#imTem").show();
     				}else{
     				    $("#imTem").hide();
     				}
        		},loadUrlData:function(){
        			var url=manageUrl+"/xt/man.do?m=get&data=list";
        			var param={pbCol:$pb.grid.pbCol(pb.cols),"pb_UrlId":14};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				var gridData = {Rows:[],Total:0};
        				if(data.code==0){
        					gridData.Rows=data.data;
        					gridData.Total=gridData.Rows.length;
        					pb.f_initGrid(gridData,"maingrid");
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
    <div style="text-align: center;"><input type="button" id="imTem" onclick="pb.imporTem()" value="模板导入"/>&nbsp;<input type="button" onclick="pb.save()" value="保存"/>&nbsp;<input type="button" onclick="pb.bulid()" value="生成" /></div>
 </div>
</body>
</html>
