/**
 * 接口规范
 */
package com.pb.ifc;

import java.util.List;
import java.util.Map;
/**
 * 操作表对象
 * @author pengbei_qq1179009513
 *
 */
public interface TableUseIfc {
	/**
	 * 当前操作的表
	 * @return 表字符串
	 */
      public String getTable();
      /**
       * 主键字段，值唯一,需要程序创建id的键
       * @return
       */
      public String getPrimaryKey();
      public String getFields();
      /**
       * 更加表获得字段信息
       * @param tb
       * @return
       */
      public String getFields(String tb);
      //查找
      /**
       * 通过对应字段的值获得对象记录
       * @param filed 字段
       * @param fildeValue 字段的值
       * @return
       */
      public Map<String,Object> findRow(String filed,Object fildeValue) throws Exception;
      /**
       * 通过主键查询记录
       * @param pkId 主键
       * @return
       */
      public Map<String,Object> findRow(String pkId) throws Exception;
      /**
       * 通过集合参数获得对象记录
       * @param map
       * @return
       */
      public Map<String,Object> findRow(Map<String,Object> map) throws Exception;
      /**
       * 通过主健参数查询集合
       * @param map
       * @return
       */
      public List<Map<String, Object>> findList(String pkId) throws Exception;
      /**
       * 通过主健和主健值参数查询集合
       * @param map
       * @return
       */
      public List<Map<String, Object>> findList(String field,Object fieldValue) throws Exception;
      /**
       * 通过集合参数查询集合
       * @param map
       * @return
       */
      public List<Map<String, Object>> findList(Map<String,Object> map) throws Exception;
      /**
       * 通过集合参数查询分页集合信息
       * @param map
       * @return
       */
      public Map<String,Object> findPage(Map<String,Object> map) throws Exception;
      //增加
      /**
       * 增加一条记录 主键id值为进行重写
       * @param pkfiled 主键
       * @param map 添加信息
       * @return
       */
      public int addRowOnlyId(Map<String,Object> map) throws Exception;
      /**
       * 增加一条记录
       * @param map
       * @return
       */
      public int addRow(Map<String,Object> map) throws Exception;
      /**
       * 增加多条记录
       * @param list
       * @return
       */
      public int[] addRows(List<Map<String,Object>> list) throws Exception;
      //删除
      /**
       * 根据主键，唯一值删除数据
       * @param pkValue 唯一值
       * @return
       */
      public int delete(Object pkValue) throws Exception;
      /**
       * 根据字段对应的值删除数据，请确保字段为唯一值【否则将删除多条记录】
       * @param field 字段
       * @param value 字段对应的值
       * @return
       */
      public int delete(String field,Object value) throws Exception;
      /**
       * 根据集合信息删除数据
       * @param map 集合信息能确定的数据，将全部删除
       * @return
       */
      public int delete(Map<String,Object> map) throws Exception;
      //修改
      /**
       * 通过主键修改对应信息
       * @param pkValue 主键的值
       * @param map 需要修改的集合信息
       * @return
       */
      public int update(Object pkValue,Map<String,Object> map) throws Exception;
      /**
       * 通过主键急值确定记录修改
       * @param field 主键字段
       * @param value 主键值
       * @param map 修改的值
       * @return
       */
      public int update(String field,Object value,Map<String,Object> map) throws Exception;
      /**
       * 通过集合条件确定记录修改成对应的集合信息  
       * @param map 需要修改成的集合信息
       * @param wMap 集合条件     
       * @return
       */
      public int update(Map<String,Object> map,Map<String,Object> wMap) throws Exception;
}
