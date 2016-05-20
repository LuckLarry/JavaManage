package com.pb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.pb.ifc.TableUseIfc;
import com.util.ItemHelper;
import com.util.JoinTable;
import com.util.WhereTable;

/**
 * 处理经常使用的方法,继承类时根据情况重写
 * 
 * @author pengbei_qq1179009513
 * 
 */
public abstract class TableUseAbs extends BaseService implements TableUseIfc {
	public abstract String getTable();
    public String getPageField(){
    	return "page,page_size,";
    }
    /**
     * 获得对应表信息
     * @param tb 表名
     * @return {keyId:唯一字段,keyS:主键list的json格式,fields:表的所有字段逗号分隔,fieldList:字段对应数据库信息}
     */
    public Map<String,Object> findCacheTable(String tb){
    	Map<String,Object> tbMap=ItemHelper.findCacheTable(tb);
    	if(tbMap==null){
    		String fiels=getFields(tb);
    		if(fiels!=null&&!"".equals(fiels)){
    			tbMap=ItemHelper.findCacheTable(tb);
    		}
    	}
    	return tbMap;
    }
    public String getFields(){
    	return getFields(getTable());
    }
    public String getFields(String tb) {
    	Map<String,Object> tbMap=ItemHelper.findCacheTable(tb);
    	if(tbMap!=null){
    		return tbMap.get("fields").toString();
    	}
		String fields = "";
		try {
			Map<String,Object> tbInfoMap=new HashMap<String, Object>();
			if (tb.length() > 0) {
				List<Map<String, Object>> list = jdbcTemplate
						.queryForList("show full fields from ".concat(tb));
				String Field = null;
				String Key=null;
				List<String> listPk = new ArrayList<String>();
				for (Map<String, Object> map : list) {
					Key = map.get("Key").toString();
					Field = map.get("Field").toString().trim();
					if ("PRI".equals(Key)) {
						listPk.add(Field);
					}
					fields += Field+",";
				}
				Gson gson=new Gson();
				tbInfoMap.put("keyId",listPk.get(0));
				tbInfoMap.put("keyS",gson.toJson(listPk));
				tbInfoMap.put("fields", fields);
				tbInfoMap.put("fieldList", list);
				ItemHelper.cacheTable(tb, tbInfoMap);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fields;
	}
	public abstract String getPrimaryKey();
    
	public Map<String, Object> findRow(String filed, Object fildeValue) throws Exception{
		WhereTable whereTable = new WhereTable(filed, fildeValue);
		return findRow(whereTable.getMap());
	}

	public Map<String, Object> findRow(String pkId) throws Exception{
		return findRow(getPrimaryKey(), pkId);
	}
	protected String getFindCol(Map<String, Object> map) {
		String col="*";
		if(map.containsKey("pbCol")){
			col=map.get("pbCol").toString();
			if(col.indexOf("select")!=-1||col.indexOf("delete")!=-1||col.indexOf("update")!=-1||col.indexOf("insert")!=-1||col.indexOf("case")!=-1){
				col="*";//处理sql注入
			}
			map.remove("pbCol");
		}
		return col;
	}
	public Map<String, Object> findRow(Map<String, Object> map) throws Exception{
		return selectRow(getTable(),getFindCol(map), map);
	}

	public int addRowOnlyId(Map<String, Object> map) throws Exception {
		return addRow(map);
	}

	public int addRow(Map<String, Object> map) throws Exception{
		return insert(getTable(), map);
	}

	public int[] addRows(List<Map<String, Object>> list) throws Exception {
		return insert(getTable(), list);
	}

	public final List<Map<String, Object>> findList(String pkId) throws Exception {
		return findList(getPrimaryKey(), pkId);
	}

	public final List<Map<String, Object>> findList(String field,
			Object fieldValue) throws Exception{
		WhereTable whereTable = new WhereTable(field, fieldValue);
		return findList(whereTable.getMap());
	}

	@Override
	public List<Map<String, Object>> findList(Map<String, Object> map) throws Exception {
		return select(getTable(),getFindCol(map), map);
	}

	@Override
	public Map<String, Object> findPage(Map<String, Object> map) throws Exception{
		return selectPage(getTable(), getFindCol(map), map);
	}

	@Override
	public int delete(Object pkValue) throws Exception{
		return delete(getPrimaryKey(), pkValue);
	}

	@Override
	public int delete(String field, Object value) throws Exception{
		WhereTable whereTable = new WhereTable(field, value);
		return delete(whereTable.getMap());
	}

	@Override
	public int delete(Map<String, Object> map) throws Exception {
		return delete(getTable(), map);
	}

	@Override
	public int update(Object pkValue, Map<String, Object> map) throws Exception{
		return update(getPrimaryKey(), pkValue, map);
	}

	@Override
	public int update(String field, Object value, Map<String, Object> map) throws Exception{
		WhereTable whereTable = new WhereTable(field, value);
		return update(map, whereTable.getMap());
	}

	@Override
	public int update(Map<String, Object> map, Map<String, Object> wMap) throws Exception{
		return update(getTable(),map, wMap);
	}
	
	protected Map<String, Object> putTree(Map<String, Object> map) throws Exception{
		Map<String, Object> treeMap = new HashMap<String, Object>();
		if (map.containsKey("parent_row_id")&&!ItemHelper.isEmpty(map.get("parent_row_id"))) {
			Map<String, Object> parentMap = findRow("row_id",
					map.get("parent_row_id"));
			treeMap = getTree(map.get("parent_row_id").toString(), parentMap
					.get("tree_row_id").toString());
		} else {
			treeMap = getTree("", "");
		}
		map.putAll(treeMap);
		return map;
	}
	
	/**
	 * 
	 * @param map 参数
	 * @param cols 查询字段
	 * @param tableJoin 连接表信息
	 * @return {tableJoin：连接表信息,map:参数,cols:查找的列信息,fieldList：对应表的字段集合信息,表名：{alias:对应别名,fieldList:当前表字段信息}}
	 */
		@SuppressWarnings({ "unchecked" })
		public Map<String,Object> replaceDbInfo(Map<String, Object> map, String cols,
				String tableJoin) {
			Map<String,Object> tableMap=new HashMap<String, Object>();
			Gson gson=(new GsonBuilder()).create();
			List<Map<String,String>> joinList=gson.fromJson(tableJoin, List.class);
			JoinTable jTb=new JoinTable();
			WhereTable wTable=new WhereTable();
			String aliasStr=null;
			String tableStr=null;
			String joinStr=null;
			String onSql=null;
			Map<String, Object> caheMap=null;
			List<Map<String, Object>> fieldList=new ArrayList<Map<String,Object>>();
			Map<String, Object> tableInfoMap=new HashMap<String, Object>();
			List<Map<String, Object>> filedList=null;
			cols=(","+cols+",");
			for (Map<String, String> aliasMap : joinList) {
				aliasStr=aliasMap.get("alias").toString();
				tableStr=aliasMap.get("name").toString();
				if(aliasMap.containsKey("join")){
					joinStr=aliasMap.get("join").toString().trim();
					onSql=aliasMap.get("on").toString().trim();
					if("".equals(joinStr)){
						jTb=new JoinTable(tableStr,aliasStr);
					}else if("left".equals(joinStr)){
						jTb.leftJoin(tableStr, aliasStr, onSql);
					}else if("right".equals(joinStr)){
						jTb.rightJoin(tableStr, aliasStr, onSql);
					}else if("inner".equals(joinStr)){
						jTb.innerJoin(tableStr, aliasStr, onSql);
					}
				}else{
					jTb=new JoinTable(tableStr,aliasStr);
				}
				caheMap=findCacheTable(tableStr);
				String fieldStr=caheMap.get("fields").toString();
				String[] fields=null;
				String col=null;
				if(cols!=null&&!"".equals(cols)&&!"*".equals(cols)){
					fields=cols.split(",");
					for (int i = 0; i < fields.length; i++) {
						col=fields[i].trim()+",";
						if(",".equals(col)){
							continue;
						}
						if(fieldStr.indexOf(col)!=-1){
							cols=cols.replace(","+col, ","+aliasStr+"."+col);
						}
					}
				}
				fields=fieldStr.split(",");
				for (int i = 0,len=fields.length; i < len; i++) {
					col=fields[i].trim();
					if(map.containsKey(col)){
						wTable.put(aliasStr+"."+col, map.get(col));
						map.remove(col);
					}
					if(map.size()==0){
						break;
					}
				}
				filedList=(List<Map<String, Object>>) caheMap.get("fieldList");
				fieldList.addAll(filedList);
				tableInfoMap.put("alias", aliasStr);
				tableInfoMap.put("fieldList", filedList);
				tableMap.put(tableStr, tableInfoMap);
			}
			map.putAll(wTable.getMap());
			tableMap.put("tableJoin", jTb.toString());
			tableMap.put("map", map);
			tableMap.put("cols", cols.substring(1, cols.length()-1));
			tableMap.put("fieldList", fieldList);
			return tableMap;
		}
}
