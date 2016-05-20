package com.util;


/**
 * 连接表处理
 * 
 * @author pengbei_qq1179009513
 * 
 */
public class JoinTable {
	private StringBuffer sqlBuffer = null;

	public JoinTable() {
		sqlBuffer = new StringBuffer();
	}

	public JoinTable(String tableName) {
		this();
		sqlBuffer.append(tableName);
	}

	public JoinTable(String tableName, String alias) {
		this();
		sqlBuffer.append(tableName).append(" ").append(alias);
	}

	public void leftJoin(String tableName, String alias, String onSql) {
		joinAppend(" left join ", tableName, alias, onSql);
	}

	public void rightJoin(String tableName, String alias, String onSql) {
		joinAppend(" right join ", tableName, alias, onSql);
	}

	public void innerJoin(String tableName, String alias, String onSql) {
		joinAppend(" inner join ", tableName, alias, onSql);
	}

	public void Join(String tableName, String alias, String onSql) {
		joinAppend(" , ", tableName, alias, onSql);
	}

	private void joinAppend(String join, String tableName, String alias,
			String onSql) {
		sqlBuffer.append(join).append(tableName).append(" ").append(alias);
		if (onSql != null && !"".equals(onSql)) {
			sqlBuffer.append(" on (").append(onSql).append(")");
		}

	}

	public String toString() {
		return sqlBuffer.toString();
	}
}
