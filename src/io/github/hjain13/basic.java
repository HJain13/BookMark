package io.github.hjain13;

import java.sql.Statement;

public interface basic {
	public void init(Statement stmt) throws Exception;
	public void newEntry(String attrValue0[], Statement stmt) throws Exception;
	public int countEntry(Statement stmt) throws Exception;
	public String[] getAttrName();
	public void setAttrName(String[] attrName);
	public String getTableName();
	public void setTableName(String tableName);
}
