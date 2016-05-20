package com.pb.factory;

import org.springframework.web.context.WebApplicationContext;
/**
 * spring 管理的bean
 * @author pengbei_qq1179009513
 *
 */
public class FactoryBean {

	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	private static WebApplicationContext wctx;

	public static WebApplicationContext getCtx() {
		return wctx;
	}

	public static void setCtx(WebApplicationContext ctx) {
		wctx = ctx;
	}

	public static Object getBean(String beanName) {
		return wctx.getBean(beanName);
	}

}