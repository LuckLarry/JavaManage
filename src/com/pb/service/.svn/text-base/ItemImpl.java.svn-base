package com.pb.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;

import org.springframework.stereotype.Service;

import com.pb.ifc.ItemDao;

@Service("sys_page")
public class ItemImpl implements ItemDao {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#createFolder(java.lang.String)
	 */
	public void createFolder(String path) {
		File file = getFile(path);
		if (!file.exists()) {
			file.setWritable(true, false);
			file.mkdirs();
		}
	}

	/**
	 * 创建File的实例，这里判断让整个程序使用同一个实例，性能上有一定的优化
	 * 
	 * @param path
	 */
	protected File getFile(String path) {
		File file = new File(repPath(path));
		return file;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#repPath(java.lang.String)
	 */
	public String repPath(String path) {
		path = path.replace('\\', '/');
		return path;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.yc.dao.impl.c_sys_cr_pageDao#createFolderAndFile(java.lang.String)
	 */
	public void createFolderAndFile(String path) {
		path = repPath(path);
		if (path.indexOf('.') >= 0) {
			createFolder(path.substring(0, path.lastIndexOf("/")));
		} else {
			createFolder(path);
		}
	}

	/**
	 * 创建写在path里的FileWriter流
	 * 
	 * @param path
	 */
	protected FileWriter getFileWriter(String path) {
		createFolderAndFile(path);
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(getFile(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileWriter;
	}

	/**
	 * 创建写在path里的FileWriter流
	 * 
	 * @param path
	 *            文件路径
	 */
	protected FileReader getFileReader(String path) {
		createFolderAndFile(path);
		FileReader fileReader = null;
		try {
			fileReader = new FileReader(getFile(path));
			// bufferedReader = new BufferedReader(fileReader);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileReader;
	}

	/**
	 * 创建写在path里的FileWriter流
	 * 
	 * @param path
	 *            文件路径
	 */
	protected BufferedReader getBufferedReader(String path, String econding) {
		createFolderAndFile(path);
		BufferedReader bufferedReader = null;
		try {
			FileInputStream fileInputStream = new FileInputStream(getFile(path));
			bufferedReader = new BufferedReader(new InputStreamReader(
					fileInputStream, econding));
			fileInputStream = null;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bufferedReader;
	}

	/**
	 * 获得BufferedWriter 的实例---还没用上
	 * 
	 * @param path
	 */
	protected BufferedWriter getBufferedWriter(String path) {
		BufferedWriter bufferedWriter = null;
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(getFile(path));
			bufferedWriter = new BufferedWriter(fileWriter);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			closeFileWriter(fileWriter);
		}
		return bufferedWriter;
	}

	/**
	 * 创建输出流，可以设置编码格式
	 * 
	 * @param path
	 * @param encoding
	 */
	protected PrintStream getPrintStream(String path, String encoding) {
		createFolderAndFile(path);
		PrintStream ps = null;
		try {
			ps = new PrintStream(getFile(path), encoding);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return ps;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#createFolder(java.lang.String,
	 * java.lang.String)
	 */
	public void createFolder(String path, String name) {
		createFolder(pathAdd(path, name));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#hasFolder(java.lang.String,
	 * java.lang.String)
	 */
	public boolean hasFolder(String path, String name) {
		return hasFolder(pathAdd(path, name));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#pathAdd(java.lang.String,
	 * java.lang.String)
	 */
	public String pathAdd(String path, String name) {
		path += "/" + name;
		return path;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#hasFolder(java.lang.String)
	 */
	public boolean hasFolder(String path) {
		File file = getFile(path);
		return file.exists();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#createFile(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	public void createFile(String path, String content, String name) {
		path = pathAdd(path, name);
		createFile(path, content);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#createFile(java.lang.String,
	 * java.lang.String)
	 */
	public void createFile(String path, String content) {
		FileWriter fileWriter = getFileWriter(path);
		try {
			fileWriter.write(content);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			closeFileWriter(fileWriter);
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#closeFileWriter()
	 */
	public void closeFileWriter(FileWriter fileWriter) {
		try {
			fileWriter.flush();
			fileWriter.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#fileWriter(java.lang.String,
	 * java.lang.String)
	 */
	public void fileWriter(String path, String content) {
		FileWriter fileWriter = getFileWriter(path);
		try {
			fileWriter.write(content);
			fileWriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			closeFileWriter(fileWriter);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#writeInputStream(java.lang.String,
	 * java.io.InputStream)
	 */
	public void writeInputStream(String path, InputStream inputStream) {
		writeInputStream(path, inputStream, 10000);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#writeInputStream(java.lang.String,
	 * java.io.InputStream, int)
	 */
	public void writeInputStream(String path, InputStream inputStream,
			int length) {
		PrintStream ps = getPrintStream(path, "UTF-8");
		byte[] b = new byte[length];
		try {
			inputStream.read(b);
			ps.write(b, 0, length);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			closeInputStream(inputStream);
			closePrintStream(ps);
		}
	}

	private void closeInputStream(InputStream inputStream) {
		try {
			if (inputStream != null) {
				inputStream.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#fileWriterLine(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	public void fileWriterLine(String path, String content, String encoding) {
		PrintStream ps = getPrintStream(path, encoding);
		ps.println(content);
		closePrintStream(ps);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#delete(java.lang.String)
	 */
	public boolean delete(String path) {
		File file = getFile(path);
		File[] fList = file.listFiles();
		if (fList != null) {
			for (int i = 0; i < fList.length; i++) {
				delete(fList[i].getPath());
			}
		}
		// getFile(path);//file 此类只用一个，在这需要还原，循环中的递归可能更改了file的值
		return file.delete();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#closePrintStream()
	 */
	private void closePrintStream(PrintStream ps) {
		if (ps != null) {
			ps.flush();
			ps.close();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#readFile(java.lang.String,
	 * java.lang.String)
	 */
	public String readFile(String path, String encoding) {
		StringBuffer lineStr = new StringBuffer();
		BufferedReader bufferedReader = getBufferedReader(path, encoding);
		try {
			while (bufferedReader.ready()) {
				lineStr.append(bufferedReader.readLine()).append("\r\n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			closeBufferedReader(bufferedReader);
		}
		return lineStr.toString();
	}

	private void closeBufferedReader(BufferedReader bufferedReader) {
		try {
			if (bufferedReader != null) {
				bufferedReader.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#readFile(java.lang.String)
	 */
	public String readFile(String path) {
		FileReader fileReader = getFileReader(path);
		return readFile(path, fileReader.getEncoding());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#writerFile(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	public void writerFile(String path, String content, String encoding) {
		fileWriterLine(path, content, encoding);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#writerFile(java.lang.String,
	 * java.lang.String)
	 */
	public void writerFile(String path, String content) {
		FileReader fileReader = getFileReader(path);
		writerFile(path, content, fileReader.getEncoding());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#reMove(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	public void reMove(String path, String pathRem, String encoding) {
		try {
			copy(path, pathRem, encoding);
			delete(path);
		} catch (RuntimeException e) {

			e.printStackTrace();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#copy(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	public void copy(String path, String pathRem, String encoding) {
		getFile(path);
		String content = readFile(path, encoding);
		writerFile(pathRem, content, encoding);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yc.dao.impl.c_sys_cr_pageDao#reMove(java.lang.String,
	 * java.lang.String)
	 */
	public void reMove(String path, String pathRem) {
		FileReader fileReader = getFileReader(path);
		reMove(path, pathRem, fileReader.getEncoding());
	}

	// /* (non-Javadoc)
	// * @see com.yc.dao.impl.c_sys_cr_pageDao#closeAll()
	// */
	// private void closeAll() {
	// try {
	// if (bufferedWriter != null) {
	// bufferedWriter.close();
	// }
	// if (bufferedReader != null) {
	// bufferedReader.close();
	// }
	// if (fileReader != null) {
	// fileReader.close();
	// }
	// if (ps != null) {
	// closePrintStream();
	// }
	// if (fileWriter != null) {
	// closeFileWriter();
	// }
	// if (fileInputStream != null) {
	// fileInputStream.close();
	// }
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
}