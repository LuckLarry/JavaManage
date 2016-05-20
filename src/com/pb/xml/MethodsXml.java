package com.pb.xml;
/**
 * url 调用需加的参数配置
 * @author pengbei_qq1179009513
 *
 */
public class MethodsXml {
	/**
	 * 图片m=get
	 */
	public final static String find = "m=get";
	/**
	 * 生成
	 */
	public final static String bulid = "m=bulid";
	/**
	 * 导入
	 */
	public final static String temImpot = "m=imp";
	/**
	 * 添加数据 m=add
	 */
	public final static String add = "m=add";
	/**
	 * 修改数据 m=update
	 */
	public final static String update = "m=update";
	/**
	 * 删除数据  m=del
	 */
	public final static String delete = "m=del";
	/**
	 * 短信发送  m=send
	 */
	public final static String send = "m=send";
	/**
	 * 用户登录 m=login
	 */
	public final static String login = "m=login";
	/**
	 * 用户注册 m=register
	 */
	public final static String register = "m=register";
	/**
	 * 扫码支付 m=sm
	 */
	public final static String saoma = "m=sm";
	//以上是 m
	/**
	 * 一条数据 data=one
	 */
	public final static String dateOne = "data=one";
	/**
	 * 多条数据 data=rows
	 */
	public final static String dateRows = "data=rows";
	/**
	 * 分页数据 data=page
	 */
	public final static String datePage = "data=page";
	/**
	 * 集合数据 data=list
	 */
	public final static String dateList = "data=list";
	/**
	 * 树节点形式显示数据 data=tree
	 */
	public final static String dateTree = "data=tree";
	//以下是 obj

	/**
	 * 一种分类数据 obj=class 在产品请求中用到
	 */
	public final static String objClass = "obj=class";
	/**
	 * 多行数据
	 */
//	public final static String objRows = "obj=rows";
	/**
	 * 详细数据
	 */
	public final static String objDetail = "obj=detail";
	/**
	 * 购物车数据 obj=cart 在订单请求中操作时用到
	 */
	public final static String objCart = "obj=cart";
	/**
	 * 地址数据 obj=address 在订单请求中操作时用到
	 */
	public final static String objAddr = "obj=address";
	/**
	 * 主页数据  obj=home 在用户请求操作中用到
	 */
	public final static String objHome = "obj=home";
	/**
	 * 随机数据 obj=random  根据传递参数  {page_size：条数} 控制随机条数
	 */
	public final static String objRandom = "obj=random";
	/**
	 * 发送短信方法1 obj=doa 在发送短信时用到
	 */
	public final static String objDoa = "obj=doa";
	/**
	 * 发送短信方法2 obj=dob 在发送短信时用到
	 */
	public final static String objDob = "obj=dob";
	/**
	 * 余额 obj=balance 
	 */
	public final static String objBalance = "obj=balance";
	/**
	 * 订单对应的商品信息 obj=osl
	 */
	public final static String objOrdersSKUList = "obj=osl";
	/**
	 * 字段作参数 obj=field
	 */
	public final static String objField = "obj=field";
	/**
	 * 主键作参数 obj=pk
	 */
	public final static String objPK = "obj=pk";
	/**
	 * json作参数 obj=map
	 */
	public final static String objMap = "obj=map";
	/**
	 * 数据集合通过值做为将分组
	 */
	public final static String fengzhu_value="f=v";
	/**
	 * 数据集合通知列进行分组
	 */
	public final static String fengzhu_col="f=c";
}
