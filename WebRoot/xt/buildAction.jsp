<%@page import="peng.pb.lang.StringPb"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.pb.factory.FactoryBean"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="com.pb.service.ItemImpl"%>
<%@page import="com.pb.ifc.ItemDao"%>
<%@page import="com.util.ItemHelper"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'buildAction.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
    buildAction.jsp?tb=&paf=&psf=&jsp=
    <br />tb:表名称参数
	<br />paf:action 目录 ""或者"/xx"
	<br />psf:server 目录  ""或者"/xx"
	<br />jsp:生成文件目录 目录  ""或者"/xx"<br />
	<%
	/* param_action_folder:action所在的文件夹1
	<br /> param_action_do:.do前面的名称
	<br /> param_action_name:action名称
	<br /> param_server:server对应的名称

	<br /> param_server_folder:server所在的文件夹1
	<br /> param_server:@Service("param_server")
	<br /> param_server_name:server名称
	<br /> param_table_name:TName里的表名1
	<br /> param_server_pk:表的主键
	*/
		boolean tableBool = true;
		String tb = request.getParameter("tb");
		String paf = request.getParameter("paf");
		String psf = request.getParameter("psf");
		String jsp = request.getParameter("jsp");
		if (tb == null || "".equals(tb)) {
			writeLn(out, "没有传递表信息");
			tableBool = false;
			return;
		}
		ItemDao itemdao = new ItemImpl();
		String tNPath = ItemHelper.getItemPath()
				+ "/src/com/pb/xml/TName.java";
		out.write("修改tName文件<br/>");
		String tNStr = itemdao.readFile(tNPath);
		String param_action_do =paf+"/"+tb+".do";
		if(jsp!=null){
			  creatJspGrid(tb, param_action_do, jsp+"/"+tb+".jsp");
		}
		if (tNStr.indexOf("\"" + tb + "\"") != -1) {
			writeLn(out, "生成表结构已经存在！");
			tableBool = false;			
			return;
		}
		tNStr = tNStr.replace("//@pbAdd", "	public static String " + tb
				+ " = \"" + tb + "\";\r\n//@pbAdd");
		itemdao.writerFile(tNPath, tNStr);
		//writeLn(out, tNStr);
		if (tableBool) {
			//String param_action_folder = paf.replace("/", ".");			
			String param_action_name = tb + "Action";
			//String param_server_folder = psf.replace("/", ".");
			String param_server = tb + "_Ser";
			String param_server_name = tb+ "Server";
			String param_table_name = tb;
			String param_server_pk = getPK(tb).get(0);
			String param_table_fields = getFields(tb);
            if(paf!=null){
				boolean action = createAction(paf,
						param_action_do, param_action_name, param_server);
				if (!action) {
					writeLn(out, "action error!");
					return;
				}
			}
			if(psf!=null){
			boolean server = createServer(psf,
					param_server, param_server_name, param_table_name,
					param_server_pk, param_table_fields);
			if (!server) {
				writeLn(out, "server error!");
				return;
			}
			}
			if(jsp!=null){
			  creatJspGrid(tb, param_action_do, jsp+"/"+tb+".jsp");
			}
		}
		
	%>
	<%!
	ItemDao itemdao = new ItemImpl();
	private void writeLn(JspWriter out, String str) throws Exception {
		out.write(str + "<br>");
	}
	private boolean createAction(String paf,
			String param_action_do, String param_action_name,
			String param_server) {
		try {
			String action = itemdao.readFile(ItemHelper.getItemPath()
					+ "/WebRoot/xt/action.txt");
			action = action.replace("${param_action_folder}",paf.replace("/", "."));
			action = action.replace("${param_action_do}", param_action_do);
			action = action.replace("${param_action_name}", param_action_name);
			action = action.replace("${param_server}", param_server);
			String actionPath = ItemHelper.getItemPath()
					+ "/src/com/pb/action/" + paf + "/"
					+ param_action_name + ".java";
			itemdao.createFolderAndFile(actionPath);
			itemdao.createFile(actionPath, action);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	private boolean createServer(String psf,
			String param_server, String param_server_name,
			String param_table_name, String param_server_pk,
			String param_table_fields) throws Exception {
		try {
			String server = itemdao.readFile(ItemHelper.getItemPath()
					+ "/WebRoot/xt/server.txt");
			server = server.replace("${param_server_folder}",psf.replace("/", "."));
			server = server.replace("${param_server}", param_server);
			server = server.replace("${param_server_name}", param_server_name);
			server = server.replace("${param_table_name}", param_table_name);
			server = server.replace("${param_server_pk}", param_server_pk);
			server = server.replace("${param_table_fields}", param_table_fields);
			String serverPath = ItemHelper.getItemPath()
					+ "/src/com/pb/service/" + psf + "/"
					+ param_server_name + ".java";
			itemdao.createFolderAndFile(serverPath);
			itemdao.createFile(serverPath, server);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	private List<String> getPK(String tb) {
		List<String> listPk = null;
		try {
			if (tb.length() > 0) {
				JdbcTemplate jdbcTemplate = (JdbcTemplate) FactoryBean
						.getBean("jdbcTemplate");
				List<Map<String, Object>> list = jdbcTemplate
						.queryForList("show full fields from ".concat(tb));
				String Field = null;
				String Key = null;
				listPk = new ArrayList<String>();
				for (Map<String, Object> map : list) {
					Key = map.get("Key").toString();
					if (!"PRI".equals(Key)) {
						continue;
					}
					Field = map.get("Field").toString();
					listPk.add(Field);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listPk;
	}
	private List<Map<String,Object>> getFullFields(String tb){
		if (tb.length() > 0) {
			JdbcTemplate jdbcTemplate = (JdbcTemplate) FactoryBean.getBean("jdbcTemplate");
			List<Map<String, Object>> list = jdbcTemplate.queryForList("show full fields from ".concat(tb));
		    return list;
		}
		return null;
	}
	private String getFields(String tb) {
		String fields = "";
		try {
			if (tb.length() > 0) {
				List<Map<String, Object>> list =getFullFields(tb);
				String Field = null;
				String Key = null;
				for (Map<String, Object> map : list) {
					Field = map.get("Field").toString();
					fields = Field+","+fields;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fields;
	}
	private void creatJspGrid(String tb,String action,String jspPath){
	        String server = itemdao.readFile(ItemHelper.getItemPath()+ "/WebRoot/Template/jsp/grid/grid.tp","utf-8");
	        List<Map<String, Object>> list =getFullFields(tb);
	        if(list!=null){
	          Gson gson=new Gson();
	          List<Map<String, Object>> reList=new ArrayList<Map<String, Object>>();
	          Map<String, Object> reMap=null;
	          Map<String,String> editMap=new HashMap<String,String>();
	          editMap.put("type", "text");
	           for (Map<String, Object> map : list) {
	               reMap=new HashMap<String,Object>();
	               reMap.put("display", map.get("Comment"));
	               reMap.put("name", map.get("Field"));
	               reMap.put("width", 100);
	               reMap.put("align", "left");
	               reMap.put("editor", editMap);
	               reList.add(reMap);
	           }
	           Map<String,String> ti=new HashMap<String,String>();
	           ti.put("${filedList}", gson.toJson(reList));
	           ti.put("${action}", action);
	           String newStr=StringPb.replace(ti, server);
	           itemdao.createFile(ItemHelper.getItemPath()+ "/WebRoot/"+jspPath, "");
	           itemdao.writerFile(ItemHelper.getItemPath()+ "/WebRoot/"+jspPath, newStr,"utf-8");
	        }
	}
	%>
</body>
</html>