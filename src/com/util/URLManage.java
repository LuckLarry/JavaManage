package com.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.pb.xml.MessageXml;


public class URLManage {
	private static Map<String, String> urlMap;
	public static void setUrlMap(Map<String, String> urlMap) {
		URLManage.urlMap = urlMap;
	}
	/**
	 * 获取URL平台配置
	 * @return
	 */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public static Map<String, String> getConfigUrl(){
    	if(URLManage.urlMap==null){
    		String url="http://localhost:8080/manage/pturl.do?m=get&data=list";
    		Map<String, String> ticketMap=new HashMap<String, String>();
    		ticketMap.put("ticket", "e895482e-7662-4aa1-bdc7-a6fb3e806ccd");
    		Gson gson=new Gson();
    		String json=URLManage.urlParamDo(url,"{}",ticketMap);
			List<Map<String, Object>> dataList=(List)gson.fromJson(json, Map.class).get(MessageXml.data_key);
			Map<String, String> reMap=new HashMap<String, String>();
			for (Map<String, Object> map : dataList) {
				reMap.put(map.get("pt_alias").toString(), map.get("pt_url").toString());
			}
    		URLManage.setUrlMap(reMap);
    	}
    	return urlMap;
    }
    public static Map<String, String> getConfigUrl(boolean ref){
    	if(ref){
    		URLManage.urlMap=null;
    	}
    	return getConfigUrl();
    }
    public static String urlParamDo(String url,String jsonMap,Map<String, String> ticketMap){
    	return urlParamDo(url, jsonMap, ticketMap,"utf-8");
    }
    public static String urlParamDo(String url,String jsonMap,Map<String, String> ticketMap,String charset)  {
		StringBuffer stb = new StringBuffer();
		InputStream in = null ;
		BufferedReader rd = null;
		InputStreamReader inRead = null;
		try {
			URLConnection connection = new URL(url).openConnection();		
			connection.setRequestProperty("Accept-Charset", charset);
			connection.setRequestProperty("Content-Type", "application/json;charset=" + charset);
			for (String key:ticketMap.keySet()) {
				connection.setRequestProperty(key,ticketMap.get(key));
			}			
			connection.setDoOutput(true);
	        DataOutputStream out = new DataOutputStream(connection.getOutputStream());
	        out.writeBytes(jsonMap);
	        out.flush();
	        out.close();
			in = connection.getInputStream();
			inRead=new InputStreamReader(in, "utf-8");
			rd=new BufferedReader(inRead);
			String str;
			while ((str = rd.readLine()) != null) {
			 stb.append(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{
				in.close();inRead.close();rd.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return stb.toString();
    }
}
