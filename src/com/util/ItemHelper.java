package com.util;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 项目所需处理类
 * 
 * @author pengbei_qq1179009513
 * 
 */
public class ItemHelper {
	/**
	 * 项目访问路径
	 */
	private static String itemUrl = null;

	/**
	 * 项目访问路径
	 */
	public static String getItemUrl() {
		return itemUrl;
	}
	private static String itemPath;
    public static String getItemPath(){
    	return itemPath;
    }
	/**
	 * 赋值 项目访问路径
	 */
	public static void setItemUrl(HttpServletRequest request) {
		itemUrl = getItemUrl(request);
	}

	/**
	 * 获得项目访问路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getItemUrl(HttpServletRequest request) {
		String path = request.getContextPath();
		itemUrl = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + path;
		return getItemUrl();
	}

	/**
	 * 把设置filed字段值对应归类
	 * 
	 * @param list
	 * @param filed
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> findFiledToKey(
			List<Map<String, Object>> list, String filed) {
		Map<String, Object> map = new HashMap<String, Object>();
		String filedV = null;
		for (Map<String, Object> rowMap : list) {
			if (rowMap.containsKey(filed)) {
				if (ItemHelper.isEmpty(rowMap.get(filed))){
					filedV = "NULL";
				} else {
					filedV = rowMap.get(filed).toString();
				}
				if (!map.containsKey(filedV)) {
					map.put(filedV, new ArrayList<Map<String, Object>>());
				}
				((List<Map<String, Object>>) map.get(filedV)).add(rowMap);
			}
		}
		return map;
	}

	/**
	 * 把对应字段归类
	 * 
	 * @param list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> findValueToFiled(
			List<Map<String, Object>> list) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (Map<String, Object> rowMap : list) {
			for (String key : rowMap.keySet()) {
				if (!map.containsKey(key)) {
					map.put(key, new ArrayList<String>());
				}
				if (rowMap.get(key) == null) {
					continue;
				}
				((List<String>) map.get(key)).add(rowMap.get(key).toString());
			}
		}
		return map;
	}

	/**
	 * 判断obj 是否为空
	 * 
	 * @param obj
	 * @return true 为空 false 不为空
	 */
	public static boolean isEmpty(Object obj) {
		if (obj == null || obj.equals("")) {
			return true;
		}
		return false;
	}

	/**
	 * 判断map中的key是否存在并且不为空
	 * 
	 * @param map
	 * @param key
	 * @return
	 */
	public static boolean isNotEmpty(Map<String, Object> map, String key) {
		if (map.containsKey(key) && map.get(key) != null
				&& !map.get(key).toString().equals("")) {
			return true;
		}
		return false;
	}

	private static String contextPath = null;

	/**
	 * 项目绝对路径
	 * 
	 * @return
	 */
	public static String getContextPath() {
		return contextPath;
	}

	/**
	 * 项目绝对路径
	 * 
	 * @param path
	 */
	public static void setContextPath(String path) {
		contextPath = path;
		if(path!=null){
			path =path.replace("\\", "/");
			path=path.substring(0,path.lastIndexOf("/"));
			itemPath=path.substring(0,path.lastIndexOf("/"));
		}
	}



	/**
	 * 创建订单号
	 * 
	 * @return
	 */
	public static String createOrderSN() {
		SimpleDateFormat datetime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return datetime.format(new Date());
	}




	/**
	 * 处理集合中key的值为空时处理成null
	 * 
	 * @param theMap
	 *            集合
	 * @param key
	 */
	public static void mapToMustNull(Map<String, Object> theMap, String key) {
		if (theMap.containsKey(key) && theMap.get(key) != null
				&& "".equals(theMap.get(key).toString())) {
			theMap.put(key, null);
		}
	}
	public static List<Map<String, Object>> getERPList(int parameter,String strflag) throws Exception{
		return getERPList(String.valueOf(parameter), strflag, "p51exc");
	}
	/**
	 * 调用ERP数据库接口
	 * 
	 * @param parameter
	 * @param strflag
	 * @param pt [p51exc:e选材，pezz168：e找砖，“”:对应pDataOutput函数]
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> getERPList(String parameter,
			String strflag, String pt) throws Exception {
		if (strflag == null) {
			return null;
		}
		StringBuffer stb = new StringBuffer();
		// //ERP URL
		String url = /* "http://192.168.239:9003/back.do";// */"http://crm.fslola.cn:9003/back.do";
		// 要传的参数
		String s = URLEncoder.encode("parameter", "utf-8").concat("=");
		s += URLEncoder.encode(parameter, "utf-8").concat("&");
		s += URLEncoder.encode("strflag", "utf-8").concat("=");
		s += URLEncoder.encode(strflag, "utf-8").concat("&");
		s += URLEncoder.encode("pt", "utf-8").concat("=");
		s += URLEncoder.encode(pt, "utf-8");

		HttpURLConnection uc = (HttpURLConnection) new URL(url)
				.openConnection();
		uc.setConnectTimeout(10000);
		uc.setDoOutput(true);
		uc.setRequestMethod("GET");
		uc.setUseCaches(false);
		DataOutputStream out = new DataOutputStream(uc.getOutputStream());

		// DataOutputStream.writeBytes将字符串中的16位的unicode字符以8位的字符形式写道流里面
		out.writeBytes(s);
		out.flush();
		out.close();

		InputStream in = new BufferedInputStream(uc.getInputStream());
		Reader rd = new InputStreamReader(in, "utf-8");
		int c = 0;
		while ((c = rd.read()) != -1) {
			stb.append((char) c);
		}
		in.close();
		// stb.toString();
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		// BufferedReader in = null;
		// try {
		// URL u = new URL(url+"?"+s);
		// in = new BufferedReader(new InputStreamReader(u.openStream()));
		// String str;
		// while ((str = in.readLine()) != null) {
		// stb.append(str);
		// }
		// } catch (Exception e) {
		// e.printStackTrace();
		// } finally {
		// in.close();
		// }
		List<Map<String, Object>> map_Value = gson.fromJson(stb.toString(),
				List.class);
		return map_Value;
	}

	/**
	 * 等于调用insert_erp(jsonstr,"701535","cltcode")
	 * 
	 * @param jsonstr
	 * @return
	 * @throws IOException
	 */
	public static StringBuffer insert_erp(String jsonstr) throws IOException {
		return insert_erp(jsonstr, "701535", "cltcode");
	}

	/**
	 * 等于调用insert_erp(jsonstr,table,"cltcode")
	 * 
	 * @param jsonstr
	 * @param table
	 * @return
	 * @throws IOException
	 */
	public static StringBuffer insert_erp(String jsonstr, String table)
			throws IOException {
		return insert_erp(jsonstr, table, "cltcode");
	}

	/**
	 * 插入erp
	 * 
	 * @param dataList
	 *            list 数据
	 * @param table
	 *            表名 或者 功能号
	 * @param whCls
	 *            插入数据的主键，根据这个字段判断erp是否 新增修改。在jsonstr 存在的字段，且大小写必须匹配
	 * @return
	 * @throws IOException
	 */
	public static StringBuffer insert_erp(List<Map<String, Object>> dataList,
			String table, String whCls) throws IOException {
		GsonBuilder gb = new GsonBuilder();
		Gson gson = gb.create();
		String jsonstr = gson.toJson(dataList);
		
		//调试脚本
		for (Map<String, Object> map:dataList) {
			if(map.containsKey("cltcode")){
				System.out.println(map.get("cltcode"));
			}
		}
		return insert_erp(jsonstr, table, whCls);
	}

	/**
	 * 插入erp
	 * 
	 * @param jsonstr
	 *            插入erp中json格式数据 为 [{}] 格式
	 * @param table
	 *            表名 或者 功能号
	 * @param whCls
	 *            插入数据的主键，根据这个字段判断erp是否 新增修改。在jsonstr 存在的字段，且大小写必须匹配
	 * @return
	 * @throws IOException
	 */
	public static StringBuffer insert_erp(String jsonstr, String table,
			String whCls) throws IOException {
		String url = "http://crm.fslola.cn:9003";
		if (isNum(table)) {
			return insert(url, jsonstr, table, whCls);
		} else {
			return insertErpTable(url, jsonstr, table, whCls);
		}
	}

	// 判断是否为数字
	@SuppressWarnings("unused")
	public static boolean isNum(String num) {
		try {
			int n = Integer.parseInt(num);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	// 通过erp功能号插入erp
	private static StringBuffer insert(String url, String jsonstr,
			String table, String whCls) throws IOException {
		jsonstr = URLEncoder.encode(jsonstr, "utf-8");
		url = url + "/opdbin.do?llhac=8800001&llhpwd=123&m=inup&formid="
				+ table + "&chkCls=" + whCls + "&jsonstr=" + jsonstr;
		return getUrl(url);
	}

	// 通过erp的表插入erp
	private static StringBuffer insertErpTable(String url, String jsonstr,
			String table, String whCls) throws IOException {
		jsonstr = URLEncoder.encode(jsonstr, "utf-8");
		url = url + "/llhome2.do?llhac=8800001&llhpwd=123&tabName=" + table
				+ "&whCls=" + whCls + "&jsonstr=" + jsonstr;
		return getUrl(url);
	}

	/**
	 * 获得url页面信息
	 * 
	 * @param url
	 *            网址
	 * @return 字符串
	 * @throws IOException
	 */
	public static StringBuffer getUrl(String url) throws IOException {
		BufferedReader in = null;
		StringBuffer stb = new StringBuffer();
		try {
			URL u = new URL(url);
			System.out.println("URL:"+url);
			in = new BufferedReader(new InputStreamReader(u.openStream(),
					"utf-8"));
			String str;
			while ((str = in.readLine()) != null) {
				stb.append(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			in.close();
		}
		return stb;
	}

	public static int add(int[] num) {
		int rNo = 0;
		for (int i = 0, len = num.length; i < len; i++) {
			rNo += num[i];
		}
		return rNo;
	}

	/**
	 * 存在key key 的int重新赋值
	 * 
	 * @param map
	 *            集合
	 * @param i
	 *            赋值key
	 * @param object
	 *            赋值
	 */
	public static void setIntToMapKey(Map<String, Object> map, int i,
			Object object) {
		String key = String.valueOf(i);
		if (map.containsKey(key)) {
			setIntToMapKey(map, i + 100, object);
		} else {
			map.put(key, object);
		}
	}

	public static StringBuffer getSqlIn(List<Map<String, Object>> matList,
			String key) {
		StringBuffer macBu = new StringBuffer();
		Map<String, Object> macMap = null;
		int len = matList.size();
		if (len > 0) {
			for (int i = 0; i < len; i++) {
				macMap = matList.get(i);
				if (i != 0) {
					macBu.append(",");
				}
				macBu.append("'").append(macMap.get(key)).append("'");
			}
		} else {
			macBu.append("''");
		}
		return macBu;
	}
	private static Map<String,Map<String,Object>> tableInfoMap=new HashMap<String, Map<String,Object>>();
	/**
	 * 缓存对应信息
	 * @param table 表 
	 * @param tableInfo {keyId:唯一字段,keyS:主键list的json格式,fields:表的所有字段逗号分隔,fieldList:字段对应数据库信息}
	 * @return
	 */
	public static void cacheTable(String table,Map<String,Object> tableInfo){
		tableInfoMap.put(table, tableInfo);
	}
	/**
	 * 查找缓存信息
	 * @param table
	 * @return {keyId:唯一字段,keyS:主键list的json格式,fields:表的所有字段逗号分隔,fieldList:字段对应数据库信息}
	 */
	public static Map<String,Object> findCacheTable(String table){
		if(tableInfoMap.containsKey(table)){
			return tableInfoMap.get(table);
		}
		return null;
	}
}
