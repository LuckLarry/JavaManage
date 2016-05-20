package com.util;

import java.text.SimpleDateFormat;
import java.util.Random;

public class CreatePrimaryKey {
	/**
	 * 生成主键值,传入平台标识和数据库标识 平台标识传值2位 数据库标识传值3位
	 */
	public static String createKey(String systemKey, String dateBaseKey) {
		SimpleDateFormat datetime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String date = datetime.format(System.currentTimeMillis());// 得到当时系统时间
		int num = (new Random().nextInt(8999999) + 1000000);// 得到4位小数
		// String strKey =
		// systemKey+"-"+dateBaseKey+"-"+date+"-"+num;///组合后return
		return new StringBuffer(systemKey).append("-").append(dateBaseKey)
				.append("-").append(date).append("-").append(num).toString();
	}


}
