package com.pb.service.xt;

import org.springframework.stereotype.Service;

import com.pb.service.TableUseAbs;
import com.pb.xml.TName;

@Service("pTemJsp_Ser")
public class pTemJspServer extends TableUseAbs {

	@Override
	public String getTable() {
		return TName.pTemJsp;
	}

	@Override
	public String getPrimaryKey() {
		return "id";
	}
	
	@Override
	public String getFields() {
		return "temText,temName,id,";
	}
}
