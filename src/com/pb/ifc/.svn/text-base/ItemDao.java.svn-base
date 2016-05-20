package com.pb.ifc;

import java.io.InputStream;

public interface ItemDao {
	/**
	 * 创建文件夹
	 * 
	 * @param path
	 *            路径不能包含文件名称，否则当文件夹创建
	 */
	public abstract void createFolder(String path);

	/**
	 * 把路径替换成正常形象 如 E:/Program Files改成E:\Program Files 并判断文件夹是否存在进行创建
	 * 
	 * @param path
	 * @return
	 */
	public abstract String repPath(String path);

	/**
	 * 创建没有的文件夹
	 * 
	 * @param path
	 *            路径中可能包含文件名称,如：E：/wo/1.txt 就只创建E：/wo文件夹
	 */
	public abstract void createFolderAndFile(String path);

	/**
	 * 根据创建文件夹的路径创建name文件夹
	 * 
	 * @param path
	 * @param name
	 */
	public abstract void createFolder(String path, String name);

	/**
	 * 此path路径 下是否有name文件夹
	 * 
	 * @param path
	 * @param name
	 * @return bool
	 */
	public abstract boolean hasFolder(String path, String name);

	/**
	 * 在path路径下连接name文件夹组成路径 
	 * 
	 * @param path
	 *            路径
	 * @param name
	 *            文件夹
	 * @return 组合成的路径
	 */
	public abstract String pathAdd(String path, String name);

	/**
	 * path路径是否存在
	 * 
	 * @param path
	 * @return bool
	 */
	public abstract boolean hasFolder(String path);

	/**
	 * 根据内容Content创建此路径下的文件
	 * 
	 * @param path
	 *            文件存放路径
	 * @param content
	 *            文件内容
	 * @param name
	 *            文件名称
	 */
	public abstract void createFile(String path, String content, String name);

	/**
	 * 根据内容Content创建此路径下的文件
	 * 
	 * @param path
	 *            文件存放路径包含文件名
	 * @param content
	 *            文件内容
	 */
	public abstract void createFile(String path, String content);

	/**
	 * 先写入一条数据，在调用处关闭文件流
	 * 
	 * @param path
	 * @param content
	 */
	public abstract void fileWriter(String path, String content);

	public abstract void writeInputStream(String path, InputStream inputStream);

	public abstract void writeInputStream(String path, InputStream inputStream,
			int length);

	/**
	 * 写入一行数据，在调用出关闭文件流，可调用此类方法closePrintStream()
	 * 
	 * @param path
	 * @param content
	 * @param encoding
	 */
	public abstract void fileWriterLine(String path, String content,
			String encoding);

	/**
	 * 删除文件或者目录及目录下的所有文件及文件夹
	 * 
	 * @param path
	 *            文件路徑
	 */
	public abstract boolean delete(String path);

	/**
	 * 读取文件
	 * 
	 * @param path
	 *            文件路径
	 * @param encoding
	 *            文件保存的编码
	 * @return
	 */
	public abstract String readFile(String path, String encoding);

	/**
	 * 将以默认编码格式读取，可能出现中文乱码， 知道编码格式，用readFile(String path, String encoding)读取
	 * 
	 * @param path
	 * @return
	 */
	public abstract String readFile(String path);

	public abstract void writerFile(String path, String content, String encoding);

	/**
	 * 在文件path存在时使用 写入文件
	 * 
	 * @param path
	 * @param content
	 */
	public abstract void writerFile(String path, String content);

	public abstract void reMove(String path, String pathRem, String encoding);

	public abstract void copy(String path, String pathRem, String encoding);

	public abstract void reMove(String path, String pathRem);

}