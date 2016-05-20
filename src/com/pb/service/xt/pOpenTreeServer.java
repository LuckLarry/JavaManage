package com.pb.service.xt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import peng.pb.lang.StringPb;

import com.google.gson.Gson;
import com.pb.service.TableUseAbs;
import com.pb.xml.MessageXml;
import com.pb.xml.TName;

@Service("pOpenTree_Ser")
public class pOpenTreeServer extends TableUseAbs {

	@Override
	public String getTable() {
		return TName.pOpenTree;
	}

	@Override
	public String getPrimaryKey() {
		return "id";
	}
	
	@Override
	public String getFields() {
		return "theNode,parentId,isexpand,des,text,url,id,";
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> findRow(Map<String, Object> map) throws Exception{
		String table=getTable();
		String cols=getFindCol(map);
		Map<String, Object> backMap=null;
		Map<String, Object> repMap=null;
		String id=null;
		if(map.containsKey(MessageXml.pb_UrlId)){
			List<Map<String, Object>> theFieldList=null;
			id=map.get(MessageXml.pb_UrlId).toString();
			map.put("id", id);
			map.remove(MessageXml.pb_UrlId);
			Map<String, Object> cacheMap=new HashMap<String, Object>();
			cacheMap.putAll(map);
			String tableJoin="[{alias:o,name:"+getTable()+",join:'',on:''},{alias:m,name:"+TName.pUrlManage+",join:'left',on:'m.urlId=o.id'},{alias:t,name:"+TName.pTemJsp+",join:'left',on:'t.id=m.temId'}]";
			repMap= replaceDbInfo(map, cols, tableJoin);
			table=repMap.get("tableJoin").toString();
			cols=repMap.get("cols").toString();
			map=(Map<String, Object>)repMap.get("map");
			backMap=selectRow(table,cols, map);
			Object aliasObj= backMap.get("tableAlias");
			repMap=null;
			if(aliasObj!=null&&!"".equals(aliasObj.toString())){
				tableJoin=aliasObj.toString();
				repMap= replaceDbInfo(map, cols, tableJoin);
				table=repMap.get("tableJoin").toString();
				cols=repMap.get("cols").toString();
				map=(Map<String, Object>)repMap.get("map");
				backMap=selectRow(table,cols, map);
				theFieldList=(List<Map<String, Object>>)repMap.get("fieldList");
			}else{
				table=backMap.get("actionTable").toString();
				theFieldList=(List<Map<String, Object>>) findCacheTable(table).get("fieldList");
			}
			if(theFieldList!=null){
				  String temText=backMap.get("temText").toString();
		          Gson gson=new Gson();
		          List<Map<String, Object>> reList=new ArrayList<Map<String, Object>>();
		          Map<String, Object> reMap=null;
//		          Map<String,String> editMap=new HashMap<String,String>();
//		          editMap.put("type", "text");
		           for (Map<String, Object> map_ : theFieldList) {
		               reMap=new HashMap<String,Object>();
		               reMap.put("display", map_.get("Comment"));
		               reMap.put("name", map_.get("Field"));
		               reMap.put("width", 100);
		               reMap.put("align", "left");
		               reMap.put("isSort", "false");
		               reList.add(reMap);
		           }
		           Map<String,String> ti=new HashMap<String,String>();
		           ti.put("${filedList}", gson.toJson(reList));
		           ti.put("${action}", backMap.get("actionDo").toString());
		           ti.put("${pb_UrlId}", backMap.get("urlId").toString());
		           String newStr=StringPb.replace(ti, temText);
		           Map<String, Object> mapSet=new HashMap<String, Object>();
		           mapSet.put("jspText", newStr);
		           update(getTable(), mapSet, cacheMap);
		           return selectRow(getTable(), "*", cacheMap);
			}
		}		
		return selectRow(getTable(), "*", map);
	}

}
