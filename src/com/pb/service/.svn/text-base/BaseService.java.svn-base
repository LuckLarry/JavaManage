package com.pb.service;

import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import pb.db.mysql.Sql;

import com.util.ItemHelper;
import com.pb.xml.MessageXml;

public class BaseService {
	/**
	 * 提供简单操作JDBC的类
	 * 
	 * */
	@Autowired
	protected SimpleJdbcTemplate simpleJdbcTemplate;
	/**
	 * 提供简单操作JDBC的类
	 * 
	 * */
	@Autowired
	protected JdbcTemplate jdbcTemplate;
	/**
	 * 提供面向javabean封装操作JDBC的类
	 * 
	 * */
	@Autowired
	protected SimpleJdbcInsert simpleJdbcInsert;
	/**
	 * 提供面向命名参数封装操作JDBC的类
	 * 
	 * */
	@Autowired
	protected NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	/**
	 * 提供面向存储过程封装操作JDBC的类
	 * 
	 * */
	@Autowired
	protected SimpleJdbcCall simpleJdbcCall;
	protected Log log = LogFactory.getLog(getClass());
	protected static Sql mySql = new Sql();

	public List<Map<String, Object>> getList(String sql) {
		return this.jdbcTemplate.queryForList(sql);
	}

	/**
	 * 获得table_name 表中的所有字段
	 * 
	 * @param table_name
	 * @return
	 */
	public Map<String, Map<String, Object>> getTableCols(String table_name) {
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		List<Map<String, Object>> cols = getList("DESC " + table_name);
		for (Map<String, Object> cMap : cols) {
			map.put(cMap.get("Field").toString(), cMap);
		}
		return map;
	}

	/**
	 * 将map数据插入到table_name表中
	 * 
	 * @param table_name
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int insert(String table_name, Map<String, Object> map) {
		Map<String, Map<String, Object>> filedMap = getTableCols(table_name);
		Map<String, Object> paramMap = mySql.insertJdbc(table_name, map,
				filedMap);
		return jdbcTemplate.update(paramMap.get("sql").toString(),
				((List<Object[]>) paramMap.get("param")).get(0));
	}

	@SuppressWarnings("unchecked")
	public int[] insert(String table_name, List<Map<String, Object>> list)
			throws Exception {
		Map<String, Map<String, Object>> filedMap = getTableCols(table_name);
		Map<String, Object> paramMap = mySql.insertJdbc(table_name, list,
				filedMap);
		return simpleJdbcTemplate.batchUpdate(paramMap.get("sql").toString(),
				(List<Object[]>) paramMap.get("param"));
	}

	/**
	 * select 查询多条的,
	 * 
	 * @param table_name
	 * @param cols
	 * @param where
	 * @return
	 */
	public List<Map<String, Object>> select(String table_name, String cols,
			Map<String, Object> where) {
		Map<String, Object> theMap = mySql.selectJdbc(table_name, cols, where);
		return simpleJdbcTemplate.queryForList(theMap.get("sql").toString(),
				(Object[]) theMap.get("param"));
	}
	public List<Map<String, Object>> select(String table_name, String cols,
			String where){
		Map<String, Object> theMap = mySql.selectJdbc(table_name, cols,null);
		String sql=theMap.get("sql").toString();
		if(where!=null&&!"".equals(where.trim())){
			sql+=" where "+where;
		}
		return simpleJdbcTemplate.queryForList(sql);
	}
	public Object selectOne(String table_name, String cols,
			String where){
		Map<String, Object> theMap = mySql.selectJdbc(table_name, cols,null);
		List<Map<String, Object>> list= simpleJdbcTemplate.queryForList(theMap.get("sql").toString()+" where "+where);
		if (list.size() > 0) {
			for (String key : list.get(0).keySet()) {
				return list.get(0).get(key);
			}
		}
		return "";
	}
	public Map<String, Object> selectRow(String table_name, String cols,
			String where){
		Map<String, Object> theMap = mySql.selectJdbc(table_name, cols,null);
		Map<String, Object> map= simpleJdbcTemplate.queryForMap(theMap.get("sql").toString()+" where "+where);
		return map;
	}
	public int delete(String table_name, Map<String, Object> where) {
		Map<String, Object> theMap = mySql.deleteJdbc(table_name, where);
		return simpleJdbcTemplate.update(theMap.get("sql").toString(),
				(Object[]) theMap.get("param"));
	}

	/**
	 * selectRow 查询一条信息
	 * 
	 * @param table_name
	 * @param cols
	 * @param where
	 * @return
	 */
	public Map<String, Object> selectRow(String table_name, String cols,
			Map<String, Object> where) {
		String add="";
		if(where.containsKey("add")){
			add=where.get("add").toString();
		}
		where.put("add", add+" limit 1");
		List<Map<String, Object>> list = select(table_name, cols, where);
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}

	/**
	 * 查询第一行第一列的值
	 * 
	 * @param table_name
	 * @param col
	 * @param where
	 * @return
	 */
	public Object selectOne(String table_name, String col,
			Map<String, Object> where) {
		Map<String, Object> theMap = mySql.selectJdbc(table_name, col, where);
		List<Map<String, Object>> list = simpleJdbcTemplate.queryForList(theMap
				.get("sql").toString(), (Object[]) theMap.get("param"));
		if (list.size() > 0) {
			for (String key : list.get(0).keySet()) {
				return list.get(0).get(key);
			}
		}
		return "";
	}

	/**
	 * 查询多条，没有条件
	 * 
	 * @param table_name
	 * @param cols
	 * @return
	 */
	public List<Map<String, Object>> select(String table_name, String cols) {
		return select(table_name, cols, "");
	}

	/**
	 * 分页查询
	 * 
	 * @param table_name
	 * @param cols
	 * @param where
	 * @return
	 */
	public Map<String, Object> selectPage(String table_name, String cols,
			Map<String, Object> where) {
		return selectPage(table_name, cols, where, table_name);
	}

	/**
	 * 分页查询
	 * 
	 * @param table_name
	 * @param cols
	 * @param where
	 * @param mainTable
	 *            主查询的表，优化性能用到
	 * @return
	 */
	public Map<String, Object> selectPage(String table_name, String cols,
			Map<String, Object> where, String mainTable) {
		if (where.get(MessageXml.page_key) == null) {
			where.put(MessageXml.page_key, 1);
		}
		if (where.get(MessageXml.pageSize_key) == null) {
			where.put(MessageXml.pageSize_key, 20);
		}
		Map<String, Object> whereNotPage = new HashMap<String, Object>();
		whereNotPage.putAll(where);
		whereNotPage.remove(MessageXml.page_key);
		whereNotPage.remove(MessageXml.pageSize_key);
		Object obj = null;
		if (whereNotPage.size() > 0) {
			obj = selectOne(table_name, "count(1)", whereNotPage);
		} else {
			obj = selectOne(mainTable, "count(1)", whereNotPage);
		}
		int count = Integer.parseInt(obj.toString());
		int page_size = Integer.parseInt(where.get(MessageXml.pageSize_key)
				.toString());
		int page = Integer.parseInt(where.get(MessageXml.page_key).toString());
		int pageCout = count / page_size + (count % page_size > 0 ? 1 : 0);
		if (page > pageCout) {
			where.put(MessageXml.page_key, 1);
		}
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put(MessageXml.page_key, where.get(MessageXml.page_key));
		pageMap.put(MessageXml.pageSize_key, where.get(MessageXml.pageSize_key));
		pageMap.put(MessageXml.pageCount_key, pageCout);
		pageMap.put(MessageXml.rowCount_key, count);
		pageMap.put(MessageXml.list_key, select(table_name, cols, where));
		return pageMap;
	}

	/**
	 * 更新一条数据
	 * 
	 * @param table_name
	 * @param mapSet
	 * @param mapWhere
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int update(String table_name, Map<String, Object> mapSet,
			Map<String, Object> mapWhere) {
		Map<String, Object> theMap = mySql.update(table_name, mapSet, mapWhere);
		return simpleJdbcTemplate.update(theMap.get("sql").toString(),
				((List<Object[]>) theMap.get("param")).get(0));
	}

	/**
	 * 更新多条数据
	 * 
	 * @param table_name
	 * @param listSet
	 * @param listWhere
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int[] update(String table_name, List<Map<String, Object>> listSet,
			List<Map<String, Object>> listWhere) {
		Map<String, Object> theMap = mySql.update(table_name, listSet,
				listWhere);
		return simpleJdbcTemplate.batchUpdate(theMap.get("sql").toString(),
				(List<Object[]>) theMap.get("param"));
	}

	public void buildTable() {
		String sql = "show tables";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		StringBuffer tableBuffer = new StringBuffer();
		tableBuffer.append("package com.ekc.xml;\r\npublic class TName {\r\n");
		for (Map<String, Object> map : list) {
			for (Object v : map.values()) {
				tableBuffer.append("public static String ")
						.append(v.toString().replace("_", "")).append(" = \"")
						.append(v).append("\";\r\n");
			}
		}
		tableBuffer.append("}");
		try {
			FileWriter fileWriter = new FileWriter(
					"D:/pbdown/exc/src/com/ekc/xml/TName.java");
			fileWriter.write(tableBuffer.toString());
			fileWriter.flush();
			fileWriter.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 调用数据库获得rowid
	 * 
	 * @return
	 */
	public String getRowId() {
		String sql = "{call P_GetRowId('tree', ?)}";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map map = (Map) this.jdbcTemplate.execute(sql,
				new CallableStatementCallback() {
					public Object doInCallableStatement(CallableStatement cs)
							throws SQLException, DataAccessException {
						cs.registerOutParameter(1, Types.VARCHAR);// 输出参数
						cs.execute();
						Map map = new HashMap();
						map.put("rowid", cs.getString(1));
						return map;
					}
				});
		return (String) map.get("rowid");
	}

	/**
	 * 获得树节点的值
	 * 
	 * @param parent_row_id
	 *            树的父节点
	 * @param tree_row_id
	 *            树的父节点tree_row_id
	 * @return <pre>
	 * { "row_id":当前节点id,
	 *  "parent_row_id":父节点id,
	 *  "tree_row_id":当前节点的tree_row_id }
	 * </pre>
	 */
	public Map<String, Object> getTree(String parent_row_id, String tree_row_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		String rowid = getRowId();
		map.put("row_id", rowid);
		map.put("parent_row_id", parent_row_id);
		if (ItemHelper.isEmpty(tree_row_id)) {
			map.put("tree_row_id", rowid);
		} else {
			map.put("tree_row_id", tree_row_id + "-" + rowid);
		}
		return map;
	}
}
