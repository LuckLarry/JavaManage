package com.pb.action.xt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import peng.pb.lang.StringPb;

import com.enumall.Message;
import com.google.gson.Gson;
import com.pb.action.BaseAction;
import com.pb.ifc.ItemDao;
import com.pb.ifc.TableUseIfc;
import com.pb.service.ItemImpl;
import com.pb.xml.MessageXml;
import com.pb.xml.MethodsXml;
import com.util.ItemHelper;

@Controller
@RequestMapping("/xt/pOpenTree.do")
public class pOpenTreeAction extends BaseAction {
	@Autowired
	TableUseIfc pOpenTree_Ser;
	@Autowired
	TableUseIfc pTemJsp_Ser;
	@Autowired
	ItemDao sys_page;
	@Override
	public TableUseIfc getTabelServer() {
		return pOpenTree_Ser;
	}
    
	@SuppressWarnings("unchecked")
	@RequestMapping(params = { MethodsXml.bulid})
	public @ResponseBody
	Map<String, Object> bulid(String id) {
		Map<String, Object> mapRe = Message.SUCCESS.getObjMess();
		try {
			Map<String, Object> map=pOpenTree_Ser.findRow(id);
			ItemDao fd=new ItemImpl();
			List<Map<String, Object>> temList=pTemJsp_Ser.findList(new Gson().fromJson("{type:'内容'}", Map.class));
			Map<String,String> ti=new HashMap<String,String>(); 
			for (Map<String, Object> rowMap:temList) {
	        	   ti.put(rowMap.get("temName").toString(), rowMap.get("temText").toString());
	        }
			String content=StringPb.replace(ti, map.get("jspText").toString());
			content=StringPb.replace(ti, content);
		    String path=ItemHelper.getItemPath()+"/WebRoot"+map.get("url").toString();
			fd.createFile(path, "");
			fd.writerFile(path, content, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
			mapRe=Message.UN_KNOW.getObjMess(e);
		}
		return mapRe;
	}
	
	@RequestMapping(params = { MethodsXml.temImpot})
	public @ResponseBody
	Map<String, Object> temImpot(String id) {
		Map<String, Object> mapRe = Message.SUCCESS.getObjMess();
		try {
			Map<String, Object> paramMap=new HashMap<String, Object>();
			paramMap.put(MessageXml.pb_UrlId, id);
			Map<String, Object> map=pOpenTree_Ser.findRow(paramMap);
			if(map==null||map.size()<=0){
				mapRe=Message.UNTREATED.getObjMess();
			}else{
				mapRe.put(MessageXml.data_key, map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mapRe=Message.UN_KNOW.getObjMess(e);
		}
		return mapRe;
	}
}
