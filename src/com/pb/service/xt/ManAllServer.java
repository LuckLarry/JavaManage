package com.pb.service.xt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.pb.service.TableUseAbs;
import com.pb.xml.MessageXml;
import com.pb.xml.TName;

@Service("manAll_Ser")
public class ManAllServer extends TableUseAbs {

	@Override
	public String getTable() {
		return TName.pUrlManage;
	}

	@Override
	public String getPrimaryKey() {
		return "id";
	}

	@SuppressWarnings("unchecked")
	@Override
	public int update(Map<String, Object> map, Map<String, Object> wMap)
			throws Exception {
		if (map.containsKey(MessageXml.pb_UrlId)) {
			String urlid = null;
			urlid = map.get(MessageXml.pb_UrlId).toString();
			map.remove(MessageXml.pb_UrlId);
			Map<String, Object> manRow = this.findRow("urlId", urlid);
			Map<String, Object> repMap = null;
			Object aliObj=manRow.get("tableAlias");
			if (aliObj != null && !"".equals(aliObj.toString())) {
				String tableJoin = aliObj.toString();
				repMap = replaceDbInfo(map, null, tableJoin);
				String table = repMap.get("tableJoin").toString();
				map = (Map<String, Object>) repMap.get("map");
				Map<String, Object> tbMap;
				List<Map<String, Object>> fieldList = null;//字段
				List<Map<String, Object>> aliasList = (new Gson()).fromJson(
						tableJoin, List.class);//别名
				boolean forBack = false;
				Map<String, Object> twMap = new HashMap<String, Object>();
				twMap.putAll(wMap);
				String c_ = null;
				for (String key : twMap.keySet()) {
					for (Map<String, Object> tMap : aliasList) {
						tbMap = (Map<String, Object>) repMap.get(tMap.get(
								"name").toString());
						fieldList = (List<Map<String, Object>>) tbMap
								.get("fieldList");
						for (Map<String, Object> fmap : fieldList) {
							c_ = fmap.get("Field").toString();
							if (c_.equals(key)) {
								wMap.put(tMap.get("alias") + "." + key,wMap.get(key));
								wMap.remove(key);
								forBack = true;
								break;
							}
						}
						if (forBack) {
							break;
						}
					}
					forBack = false;
				}
				return update(table, map, wMap);
			}else{
				return update(manRow.get("actionTable").toString(), map, wMap);
			}
		}
		return update(getTable(), map, wMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> findRow(Map<String, Object> map)
			throws Exception {
		String cols = getFindCol(map);
		if (map.containsKey(MessageXml.pb_UrlId)) {
			String urlid = null;
			urlid = map.get(MessageXml.pb_UrlId).toString();
			map.remove(MessageXml.pb_UrlId);
			Map<String, Object> manRow = this.findRow("urlId", urlid);
			Map<String, Object> repMap = null;
			Object aliObj=manRow.get("tableAlias");
			if (aliObj != null && !"".equals(aliObj.toString())) {
				String tableJoin = aliObj.toString();
				repMap = replaceDbInfo(map, cols, tableJoin);
				String table = repMap.get("tableJoin").toString();
				cols = repMap.get("cols").toString();
				map = (Map<String, Object>) repMap.get("map");
				return selectRow(table, cols, map);
			}else{
				return selectRow(manRow.get("actionTable").toString(), cols, map);
			}
		}
		return selectRow(getTable(), cols, map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findList(Map<String, Object> map)
			throws Exception {
		String urlid = null;
		String table = getTable();
		Map<String, Object> repMap = null;
		String cols = getFindCol(map);
		if (map.containsKey(MessageXml.pb_UrlId)) {
			urlid = map.get(MessageXml.pb_UrlId).toString();
			Map<String, Object> manRow = this.findRow("urlId", urlid); 
			map.remove(MessageXml.pb_UrlId);
			Object aliObj=manRow.get("tableAlias");
			if (aliObj != null && !"".equals(aliObj.toString())) {
				String tableJoin = aliObj.toString();
				repMap = replaceDbInfo(map, cols, tableJoin);
				table = repMap.get("tableJoin").toString();
				cols = repMap.get("cols").toString();
				map = (Map<String, Object>) repMap.get("map");
			}else{
				table=manRow.get("actionTable").toString();
			}
		}
		return select(table, cols, map);
	}
}
