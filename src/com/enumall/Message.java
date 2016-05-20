package com.enumall;

import java.util.HashMap;
import java.util.Map;

/**
 * 消息体
 * 
 * @author pengbei_qq1179009513
 * 
 */
public enum Message {
	/**
	 * 成功
	 * 
	 * <pre>
	 * {
	 * 	"message": "success",
	 * 	"messageTxt": "成功",
	 * 	"code": 0
	 * }
	 * </pre>
	 */
	SUCCESS(0, "success", "成功"),
	/**
	 * 账号不存在 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "have no account",
	 * 	"messageTxt": "不存在的账号",
	 * 	"code": 1
	 * }
	 */
	NO_ACCOUNT(1, "have no account", "不存在的账号"),
	/**
	 * 出错 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "error",
	 * 	"messageTxt": "出错",
	 * 	"code": 2
	 * }
	 * *
	 * </pre>
	 */
	ERROR(2, "error", "出错"),
	/**
	 * 未知错误 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "unknow",
	 * 	"messageTxt": "未知错误",
	 * 	"code": 3
	 * }
	 * *
	 * </pre>
	 */
	UN_KNOW(3, "unknow", "未知错误"),
	/**
	 * 密码错误 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "password_err",
	 * 	"messageTxt": "密码错误",
	 * 	"code": 4
	 * }
	 * *
	 * </pre>
	 */
	PASSWORD_ERR(4, "password_err", "密码错误"),
	/**
	 * 未处理 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "untreated",
	 * 	"messageTxt": "未处理",
	 * 	"code": 5
	 * }
	 * *
	 * </pre>
	 */
	UNTREATED(5, "untreated", "未处理"),
	/**
	 * 没有数据 *
	 * 
	 * <pre>
	 * {
	 * 	"message": "no_data",
	 * 	"messageTxt": "没有数据",
	 * 	"code": 6
	 * }
	 * *
	 * </pre>
	 */
	NO_DATA(6, "no_data", "没有数据"),
	/**
	 * 退出成功 * *
	 * 
	 * <pre>
	 * {
	 * 	"message": "logout success",
	 * 	"messageTxt": "退出成功",
	 * 	"code": 7
	 * }
	 * *
	 * </pre>
	 */
	EXIT(7, "logout success", "退出成功"),
	/**
	 * 不存在ticket * *
	 * 
	 * <pre>
	 * {
	 * 	"message": "not ticket",
	 * 	"messageTxt": "不存在ticket",
	 * 	"code": 8
	 * }
	 * *
	 * </pre>
	 */
	NO_TICKET(8, "not ticket", "不存在ticket"),
	/**
	 * 不存在表 * *
	 * 
	 * <pre>
	 * {
	 * 	"message": "no has table",
	 * 	"messageTxt": "不存在表",
	 * 	"code": 9
	 * }
	 * *
	 * </pre>
	 */
	NO_TABLE(9, "no has table", "不存在表"),
	/**
	 * 请勿重复收藏 * *
	 * 
	 * <pre>
	 * {
	 * 	"message": "Collection repeat",
	 * 	"messageTxt": "请勿重复收藏",
	 * 	"code": 10
	 * }
	 * *
	 * </pre>
	 */
	COLLECTION(10, "Collection repeat", "请勿重复收藏");

	private int code;
	private String mess_en;
	private String mess_zh;

	public int getCode() {
		return code;
	}

	public String getMess_en() {
		return mess_en;
	}

	public String getMess_zh() {
		return mess_zh;
	}

	private Message() {
	}

	private Message(int no, String en, String zh) {
		this.code = no;
		this.mess_en = en;
		this.mess_zh = zh;
	}

	public String toString() {
		return String.valueOf(this.code);
	}

	/**
	 * 消息对象
	 * 
	 * @return map 集合 例子：
	 * 
	 *         <pre>
	 * 	 {
	 *   "message": "success",
	 *   "messageTxt": "成功",
	 *   "code":"0"
	 * }
	 * </pre>
	 */
	public Map<String, Object> getObjMess() {
		return this.theObj(this.code, this.mess_en, this.mess_zh);
	}

	/**
	 * 消息对象
	 * 
	 * @return map 集合 例子：
	 * 
	 *         <pre>
	 * 	 {
	 *   "message": "success",
	 *   "messageTxt": "成功",
	 *   "code":"0"
	 *   }
	 * </pre>
	 */
	public Map<String, Object> getObjMess(Exception e) {
		return this.theObj(this.code, this.mess_en, e.getMessage());
	}

	/**
	 * 组成当前对象
	 * 
	 * @param code
	 *            编号
	 * @param message
	 *            en
	 * @param messsageTxt
	 *            zh
	 * @return map
	 * 
	 *         <pre>
	 * {
	 * 	"message": en,
	 * 	"messageTxt": zh,
	 * 	"code": 编号
	 * }
	 * *
	 * </pre>
	 */
	private Map<String, Object> theObj(int code, String message,
			String messsageTxt) {
		Map<String, Object> mess = new HashMap<String, Object>();
		mess.put("code", code);
		mess.put("message", message);
		mess.put("messageTxt", messsageTxt);
		return mess;
	}
}
