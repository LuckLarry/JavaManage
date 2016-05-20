package com.pb.action.xt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pb.action.BaseAction;
import com.pb.ifc.TableUseIfc;

@Controller
@RequestMapping("/pturl.do")
public class PtUrlAct extends BaseAction {
	@Autowired
	TableUseIfc urlconfigSer;

	@Override
	public TableUseIfc getTabelServer() {
		return urlconfigSer;
	}
    
}
