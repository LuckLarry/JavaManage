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
        		cols:[ 
                                {"align":"left","width":200,"name":"text",id:"id1","display":"展开显示title" ,frozen: true},      
                                {"editor":{"type":"text"},"align":"left","width":200,"name":"text","display":"title" },   			
        			{"editor":{"type":"text"},"align":"left","width":150,"name":"url","display":"跳转url"},
        			{"render": function(item){return $pb.edit.checkEdit('pb.manager',item,'isexpand',true);},"align":"left","width":30,"name":"isexpand","display":"展开"},
	 { "render": function (item){return $pb.edit.checkEdit('pb.manager',item,'isNew',true); },
        "align":"left","width":30,"name":"isNew","display":"新窗口"},
	 { "render": function (item){return $pb.edit.checkEdit('pb.manager',item,'pOpen',true); },
        "align":"left","width":50,"name":"pOpen","display":"用户可打开"},
                {"align":"left","width":80,"name":"id","display":"当前节点"},
        		{"name": "parentId", "display": "父节点", "width": 100, "align": "left"},
        		{"align":"left","width":200,"name":"theNode","display":"当前节点树","value":"A-0"},
        		{ display: '模板', isSort: false, width: 120, render: function (rowdata, rowindex, value)
                {
                    var h = "";
                        if(rowdata.url){
                        h += "<a href='javascript:pb.show(" + rowdata.id + ")'>查看</a> ";
                        h += "<a href='javascript:pb.bulid(" + rowdata.id + ")'>生成</a> "; 
                        }
                    return h;
                }
                },
        			{"editor":{"type":"text"},"align":"left","width":400,"name":"des","display":"备注"}
        			],
refField:{
        			  "parentId":{
        			  data:null,
        			  gridData:null,
        			  setGridData:function(gd){
	                           var d=$pb.clone(gd);
        		         d['Rows'].push({"id":0,"text":"起点","parentId":"","theNode":"A"});
        			     this.gridData=d;
        			     this.editor.grid.data=d;
        			  },
        			  setData:function(d_){
        			     var d=$pb.clone(d_);
        		             d.push({"id":0,"text":"起点","parentId":"","theNode":"A"});
        			     this.data=d;
        			  },
        			  editor:{
                            "type": "popup", "valueField": "id", "textField": "text", "grid":
                            {
                                "data":null,tree: { columnId: 'id1' },  "columns": [
                               { "name": "text","id":"id1", "width": 200, "display": "标题" },
                               { "name": "id", "width": 200, "display": "序号" }, 
                               { "name": "parentId", "width": 200, "display": "父节点" }]
                            },
                            "onSelected":function (e) { 
				var grid =pb.manager;
				var selected = e.data[0]; 
                                if(pb.checkError(grid.lastEditRow,selected)){
					$.ligerDialog.waitting('您的选择有误，请重新选择！！！');
				        setTimeout(function () {
				              $.ligerDialog.closeWaitting();
				         }, 1000);
					 this.setValue(grid.lastEditRow.parentId);
					 return false;
				}
				grid.lastEditRow.theNode=selected.theNode+"-"+selected.id;  
  			   },
                            "searchClick": function (e){
                                alert("这里可以根据搜索规则来搜索（下面的代码已经本地搜索),搜索规则:" + liger.toJSON(e.rules));
                                e.grid.loadData($.ligerFilter.getFilterFunction(e.rules));
                            }
                        },render:function (item)
        	              {
        	                   d=pb.refField["parentId"].data;
        	                   for(var the in d){
        	                       if(d[the]["id"]==item.parentId){
        	                         return d[the]['text'];
        	                       }
        	                    } 
        	                    return '未知';               
        	              }
                    }
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
        		    var row = pb.manager.getSelectedRow();
        		    if(pb.initValue==null){
	        			pb.initValue=$pb.grid.initRow(pb.getCols());
        			}
        		    if(row){
        		        pb.initValue["parentId"]=row["id"];
        		        pb.initValue["theNode"]=row["theNode"]+"-"+pb.initValue["parentId"];
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
	        	                { text: '保存', click: pb.saveAll, icon: 'modify' },
	        	                 { line: true },
	        	                { text: '收缩全部', click: pb.collapseAll, icon: 'modify' }
	        	                ]
        	                },
        	               enabledEdit: true,isScroll: false,pageSize:19,rownumbers:true,pageSizeOptions:[10,20,40,50],
        	                data: gridData,
        	                tree: { columnId: 'id1' },        	                
        	                width: '98%',
        	                height:'90%'
        	            };
        	            $("#"+gridId).ligerGrid(gridInfo);
        	            pb.manager = $("#"+gridId).ligerGetGridManager();
        		},saveAll:function(){        	
				$pb.Data.gridSave(pb.manager,tiketMap,manageUrl+"/xt/pOpenTree.do?m=sqlAll","id",'');
        		},loadUrlData:function(fun){
				$pb.Data.load({},tiketMap,manageUrl+"/xt/pOpenTree.do?m=get&data=list",$pb.grid.pbCol(pb.cols),function(data){
       				if(data.code==0){
       				    gridData=$pb.Data.toTreeGrid(data.data,'id','parentId');
       				    pb.gridData=gridData;
                                    pb.refField['parentId'].setGridData(gridData);
                                    pb.refField['parentId'].setData(data.data);
       				    pb.f_initGrid(gridData,"maingrid");
       				}
                	});		
        		},collapseAll:function(){
        			pb.manager.collapseAll();
        		},show:function(no){
        		   	var url=$pb.manageUrl+"/xt/pOpenTree.do?m=get&data=one";
        			var param={pbCol:"id,jspText",id:no};
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
        		},theTem:{
        		   temDiv:null,
        		   temId:null
        		},save:function(){
        		   	var url=$pb.manageUrl+"/xt/pOpenTree.do?m=update&data=one";
        			var param={id:this.theTem.temId,"jspText":$('#temT').val()};
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
        		},gridData:null ,imporTem:function(){
        		    var url=$pb.manageUrl+"/xt/pOpenTree.do?m=imp&id="+this.theTem.temId;
        			var param={};
        			$pb.DoUrl(url,param,tiketMap, function(data){
        				if(data.code==0){
        				    $('#temT').val(data.data.jspText);
                            pb.showTemButton();
        				}
                    });	
        		},showTemButton:function(){
       				var temText=$('#temT').val();
     				if(temText==""){
     				    $("#imTem").show();
     				}else{
     				    $("#imTem").hide();
     				}
        		},
        		checkError:function(parent,nodeRow){
		       		var bool = false;
		       		if(parent.id==nodeRow.id){
		       			return true;
		       		}
		       		if(parent.children){
			       		for(var par in parent.children){	       			
			       			bool = pb.checkError(parent.children[par],nodeRow);
			       			if(bool){
			       				return bool;
			       			}
			       		}
		       		}
		       		return false;
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
