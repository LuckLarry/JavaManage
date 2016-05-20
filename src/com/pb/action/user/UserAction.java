package com.pb.action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enumall.Message;
import com.google.gson.Gson;
import com.pb.action.BaseAction;
import com.pb.ifc.TableUseIfc;
import com.pb.xml.MessageXml;
import com.pb.xml.MethodsXml;
import com.util.SessionKey;

@Controller
@RequestMapping("/user/userinfo.do")
public class UserAction extends BaseAction {
	@Autowired
	TableUseIfc UserSer;

	@Override
	public TableUseIfc getTabelServer() {
		return UserSer;
	}
	/**
	 * 登录处理
	 * @param session
	 * @param loginMap
	 * @return
	 */
	@RequestMapping(params = { MethodsXml.login})
	public @ResponseBody
	Map<String, Object> loginParam(HttpSession session,String user_name,String password) {
		Map<String,Object> loginMap=new HashMap<String, Object>();
		loginMap.put("user_name", user_name);
		loginMap.put("password", password);
		return login(session, loginMap);
	}
	@RequestMapping(params = { MethodsXml.login,"data=json"})
	public @ResponseBody
	Map<String, Object> login(HttpSession session,@RequestBody Map<String,Object> loginMap) {
		Map<String, Object> mapRe = Message.SUCCESS.getObjMess();
		try {
			Map<String, Object> userMap=UserSer.findRow(loginMap);
			if (userMap == null || userMap.size() == 0) {
				mapRe = Message.NO_DATA.getObjMess();
			} else {
				Map<String, String> ticketMap=new HashMap<String, String>();
				ticketMap.put(MessageXml.ticket_key, "e895482e-7662-4aa1-bdc7-a6fb3e806ccd");
				Gson gson=new Gson();
				String ticketJson=gson.toJson(ticketMap);
				session.setAttribute(SessionKey.ticketMap, ticketJson);
				mapRe.put(SessionKey.ticketMap, ticketJson);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mapRe = Message.UN_KNOW.getObjMess(e);
		}
		return mapRe;
	}
}
