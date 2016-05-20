<%@page import="com.util.SessionKey"%>
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
    <link rel="stylesheet" type="text/css" id="mylink"/>   
    <script src="<%=basePath %>/js/Source/lib/jquery/jquery-1.9.0.min.js" type="text/javascript"></script>    
    <script src="<%=basePath %>/js/Source/lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>  
    <script src="<%=basePath %>/js/Source/lib/jquery.cookie.js"></script>
    <script src="<%=basePath %>/js/manage.js" type="text/javascript"></script>
    <script src="<%=basePath %>/js/Source/lib/json2.js"></script>
    <script src="<%=basePath %>/js/md5.js" type="text/javascript"></script>
        <script type="text/javascript">
  function jis(){
   		 hash = hex_md5($("#pwd").val());
   		 $("#password").val(hash);
   }
   function commit(){
   var username=$("#user_name").val();
   var pwd=$("#password").val();
  		$.ajax({
			type: "post",
			url: "user/userinfo.do?m=login&user_name="+username+"&password="+pwd,
			async: false,  
          	cache: false,  
			data:{},
			dataType:"json",
			 processData: false,  // 告诉jQuery不要去处理发送的数据
            contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
			success: function(data){
		    	 if(data.code==0){
				       window.location.reload();
				    }else{
				       alert("登录失败！");
				    }
			},error: function(data){
   				alert("错误"+data.message);
			}
		});
   }
        var tiketMap=<%=session.getAttribute("ticketMap")%>;
        var manageUrl=$pb.manageUrl;
        function showLogin(){
            loginMap={
	             	title:"用户登录",
	                 width:340,
	                 height:260,
	            	target: $("#login")
	             };
            if(tiketMap==null){
	            loginMap.allowClose=false;
	         }
	          $.ligerDialog.open(loginMap);
		   }
		$(function(){
		      if(tiketMap==null){
		         showLogin();
		      }else{
		         pb.tree.getData();
		      }
		});
        pb={tree:{
             getData:function(fun){
                   	var url=manageUrl+"/xt/pOpenTree.do?m=get&data=list";
      			var param={pbCol:"id,parentId,url,text,isexpand,des,theNode,isNew"};
      			$pb.DoUrl(url,param,tiketMap, function(data){
      				var treeData = {};
      				if(data.code==0){   
      					treeData=$pb.findTreeMap(data.data,"id","parentId",{"isexpand":{"0":"false","1":true}});
      					if(typeof(fun) == 'function'){
      					  fun(treeData);
      					}else{
      					  pb.tree.creatTree(treeData);
      					}				
      				}
                  });		
                },creatTree:function(data){
                    //树
	               $("#tree1").ligerTree({
	                   data : data,
	                   checkbox: false,
	                   slide: false,
	                   nodeWidth: 100,
	                   attribute: ['nodename', 'url'],
	                   render : function(a){
	                       if (!a.isNew) return a.text;
	                      return '<a href="'+manageUrl + a.url + '" target="_blank">' + a.text + '</a>';
	                   },
	                   onSelect: function (node){
	                       if (node.data.isNew) return;
	                       var tabid = $(node.target).attr("tabid");
	                       if (!tabid){
	                           tabid = new Date().getTime();
	                           $(node.target).attr("tabid", tabid);
	                       } 
	                       var url=node.data.url;
	                       if(url.indexOf("http")==-1){
	                          url=manageUrl+url;
	                       }
	                       f_addTab(tabid, node.data.text, url);
	                   }
	               });
                }
               }
            };
 
            var tab = null;
            var accordion = null;
            var tree = null;
            var tabItems = [];
            $(function ()
            {

                //布局
                $("#layout1").ligerLayout({
                    leftWidth: 190,
                    height: '100%',
                    heightDiff: -34,
                    space: 4,
                    onHeightChanged: f_heightChanged,
                    onLeftToggle: function ()
                    {
                        tab && tab.trigger('sysWidthChange');
                    },
                    onRightToggle: function ()
                    {
                        tab && tab.trigger('sysWidthChange');
                    }
                });

                var height = $(".l-layout-center").height();

                //Tab
                tab = $("#framecenter").ligerTab({
                    height: height,
                    showSwitchInTab : true,
                    showSwitch: true,
                    onAfterAddTabItem: function (tabdata)
                    {
                        tabItems.push(tabdata);
                        saveTabStatus();
                    },
                    onAfterRemoveTabItem: function (tabid)
                    { 
                        for (var i = 0; i < tabItems.length; i++)
                        {
                            var o = tabItems[i];
                            if (o.tabid == tabid)
                            {
                                tabItems.splice(i, 1);
                                saveTabStatus();
                                break;
                            }
                        }
                    },
                    onReload: function (tabdata)
                    {
                        var tabid = tabdata.tabid;
                        addFrameSkinLink(tabid);
                    }
                });

                //面板
                $("#accordion1").ligerAccordion({
                    height: height - 24, speed: null
                });

                $(".l-link").hover(function ()
                {
                    $(this).addClass("l-link-over");
                }, function ()
                {
                    $(this).removeClass("l-link-over");
                });
            

                function openNew(url)
                { 
                    var jform = $('#opennew_form');
                    if (jform.length == 0)
                    {
                        jform = $('<form method="post" />').attr('id', 'opennew_form').hide().appendTo('body');
                    } else
                    {
                        jform.empty();
                    } 
                    jform.attr('action', url);
                    jform.attr('target', '_blank'); 
                    jform.trigger('submit');
                };


                tab = liger.get("framecenter");
                accordion = liger.get("accordion1");
                tree = liger.get("tree1");
                $("#pageloading").hide();

                css_init();
                pages_init();                
            });
            function f_heightChanged(options)
            {  
                if (tab)
                    tab.addHeight(options.diff);
                if (accordion && options.middleHeight - 24 > 0)
                    accordion.setHeight(options.middleHeight - 24);
            }
            function f_addTab(tabid, text, url)
            {
                tab.addTabItem({
                    tabid: tabid,
                    text: text,
                    url: url,
                    callback: function ()
                    {
                        addShowCodeBtn(tabid); 
                        addFrameSkinLink(tabid); 
                    }
                });
            }
            function addShowCodeBtn(tabid)
            {               
                var jiframe = $("#" + tabid);
                viewSourceBtn.insertBefore(jiframe);
                viewSourceBtn.click(function ()
                {
                    showCodeView(jiframe.attr("src"));
                }).hover(function ()
                {
                    viewSourceBtn.addClass("viewsourcelink-over");
                }, function ()
                {
                    viewSourceBtn.removeClass("viewsourcelink-over");
                });
            }
            function addFrameSkinLink(tabid)
            {
                var prevHref = "";//getLinkPrevHref(tabid) || "";
                var skin = getQueryString("skin");
                if (!skin) return;
                skin = skin.toLowerCase();
                attachLinkToFrame(tabid, prevHref + skin_links[skin]);
            }
            var skin_links = {
                "aqua": "<%=basePath %>/js/Source/lib/ligerUI/skins/Aqua/css/ligerui-all.css",
                "gray": "<%=basePath %>/js/Source/lib/ligerUI/skins/Gray/css/all.css",
                "silvery": "<%=basePath %>/js/Source/lib/ligerUI/skins/Silvery/css/style.css",
                "gray2014": "<%=basePath %>/js/Source/lib/ligerUI/skins/gray2014/css/all.css"
            };
            function pages_init()
            {
                var tabJson = $.cookie('liger-home-tab'); 
                if (tabJson)
                { 
                    var tabitems = JSON2.parse(tabJson);
                    for (var i = 0; tabitems && tabitems[i];i++)
                    { 
                        f_addTab(tabitems[i].tabid, tabitems[i].text, tabitems[i].url);
                    } 
                }
            }
            function saveTabStatus()
            { 
                $.cookie('liger-home-tab', JSON2.stringify(tabItems));
            }
            function css_init()
            {
                var css = $("#mylink").get(0), skin = getQueryString("skin");
                $("#skinSelect").val(skin);
                $("#skinSelect").change(function ()
                { 
                    if (this.value)
                    {
                        location.href = "index.jsp?skin=" + this.value;
                    } else
                    {
                        location.href = "index.jsp";
                    }
                });

               
                if (!css || !skin) return;
                skin = skin.toLowerCase();
                $('body').addClass("body-" + skin); 
                $(css).attr("href", skin_links[skin]); 
            }
            function getQueryString(name)
            {
                var now_url = document.location.search.slice(1), q_array = now_url.split('&');
                for (var i = 0; i < q_array.length; i++)
                {
                    var v_array = q_array[i].split('=');
                    if (v_array[0] == name)
                    {
                        return v_array[1];
                    }
                }
                return false;
            }
            function attachLinkToFrame(iframeId, filename)
            { 
                if(!window.frames[iframeId]) return;
                var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
                var fileref = window.frames[iframeId].document.createElement("link");
                if (!fileref) return;
                fileref.setAttribute("rel", "stylesheet");
                fileref.setAttribute("type", "text/css");
                fileref.setAttribute("href", filename);
                head.appendChild(fileref);
            }
            function getLinkPrevHref(iframeId)
            {
                if (!window.frames[iframeId]) return;
                var head = window.frames[iframeId].document.getElementsByTagName('head').item(0);
                var links = $("link:first", head);
                for (var i = 0; links[i]; i++)
                {
                    var href = $(links[i]).attr("href");
                    if (href && href.toLowerCase().indexOf("ligerui") > 0)
                    {
                        return href.substring(0, href.toLowerCase().indexOf("lib") );
                    }
                }
            }
     </script> 
<style type="text/css"> 
    body,html{height:100%;}
    body{ padding:0px; margin:0;   overflow:hidden;}  
    .l-link{ display:block; height:26px; line-height:26px; padding-left:10px; text-decoration:underline; color:#333;}
    .l-link2{text-decoration:underline; color:white; margin-left:2px;margin-right:2px;}
    .l-layout-top{background:#102A49; color:White;}
    .l-layout-bottom{ background:#E5EDEF; text-align:center;}
    #pageloading{position:absolute; left:0px; top:0px; background:white url('<%=basePath%>/js/Source/lib/images/loading.gif') no-repeat center; width:100%; height:100%;z-index:99999;}
    .l-link{ display:block; line-height:22px; height:22px; padding-left:16px;border:1px solid white; margin:4px;}
    .l-link-over{ background:#FFEEAC; border:1px solid #DB9F00;} 
    .l-winbar{ background:#2B5A76; height:30px; position:absolute; left:0px; bottom:0px; width:100%; z-index:99999;}
    .space{ color:#E7E7E7;}
    /* 顶部 */ 
    .l-topmenu{ margin:0; padding:0; height:31px; line-height:31px; background:url('<%=basePath%>/js/Source/lib/images/top.jpg') repeat-x bottom;  position:relative; border-top:1px solid #1D438B;  }
    .l-topmenu-logo{ color:#E7E7E7; padding-left:35px; line-height:26px;background:url('lib/images/topicon.gif') no-repeat 10px 5px;}
    .l-topmenu-welcome{  position:absolute; height:24px; line-height:24px;  right:30px; top:2px;color:#070A0C;}
    .l-topmenu-welcome a{ color:#E7E7E7; text-decoration:underline} 
     .body-gray2014 #framecenter{
        margin-top:3px;
    }
      .viewsourcelink {
         background:#B3D9F7;  display:block; position:absolute; right:10px; top:3px; padding:6px 4px; color:#333; text-decoration:underline;
    }
    .viewsourcelink-over {
        background:#81C0F2;
    }
    .l-topmenu-welcome label {color:white;
    }
    #skinSelect {
        margin-right: 6px;
    }
 </style>
</head>
<body style="padding:0px;background:#EAEEF5;">  
<div id="pageloading"></div>  
<div id="topmenu" class="l-topmenu">
       <div class="l-topmenu-welcome">
        <a href="javascript:void(0);" onclick="showLogin();">登录</a>
        <label> 皮肤切换：</label>
        <select id="skinSelect">
            <option value="aqua">默认</option> 
            <option value="silvery">Silvery</option>
            <option value="gray">Gray</option>
            <option value="gray2014">Gray2014</option>
        </select>
        <a href="index.aspx" class="l-link2">服务器版本</a>
        <span class="space">|</span>
        <a href="#" class="l-link2" target="_blank">捐赠</a> 
                <span class="space">|</span>
        <a href="#" class="l-link2" target="_blank">服务支持</a> 
    </div> 
</div>
  <div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; "> 
        <div position="left"  title="主要菜单" id="accordion1"> 
                     <div title="功能列表" class="l-scroll">
                         <ul id="tree1" style="margin-top:3px;">
                    </div>
                    <div title="应用场景">
                    <div style=" height:7px;"></div>
                        <a class="l-link" href="#" target="_blank">演示系统</a>  
                         <a class="l-link" href="javascript:f_addTab('listpage','列表页面','<%=basePath%>/js/Source/demos/case/listpage.htm')">列表页面</a> 
                         <a class="l-link" href="<%=basePath%>/js/Source/demos/dialog/win7.htm" target="_blank">模拟Window桌面</a> 
                        <a class="l-link" href="javascript:f_addTab('week','工作日志','<%=basePath%>/js/Source/demos/case/week.htm')">工作日志</a>  
                    </div>    
                     <div title="实验室">
                    <div style=" height:7px;"></div>
                          <a class="l-link" href="lab/generate/index.htm" target="_blank">表格表单设计器</a> 
                          <a class="l-link" href="lab/formdesign/index.htm" target="_blank">可视化表单设计</a> 
                    </div> 
        </div>
        <div position="center" id="framecenter"> 
            <div tabid="home" title="我的主页" style="height:300px" >
                <iframe frameborder="0" name="home" id="home" src="<%=basePath %>/js/Source/demos/dialog/win7.htm"></iframe>
            </div> 
        </div>         
    </div>
    <div  style="height:32px; line-height:32px; text-align:center;">
            Copyright © 2011-2014 
    </div>
    <div style="display:none"></div>
<div id="login" style="width: 280px; display:none; height: 150px;background-color: #FFFFFF;text-align: center;border: solid 1px;padding: 10px;">
<form action="user/userinfo.do?m=login" method="post" id="loginForm" onkeypress="if(event.keyCode==13||event.which==13){commit();}">
<div id="panel" style="background-color: #CCFFFF;padding: 10px;margin: 10px;font-size:18px; ">
<table>
<tr>
	<td>账 号：</td><td><input type="text" size="20" id="user_name" name="user_name" /></td>
</tr>
<tr>
	<td>密 码：</td><td><input type="password" size="20" id="pwd" onblur="jis()"/><input type="hidden" id="password" name="password" value="" /> </td>
</tr>
</table>
</div>
<input type="reset" value="重置" />&nbsp;<input type="button" value="登录" onclick="commit()"/>
</form>
</div>
</body>
</html>
