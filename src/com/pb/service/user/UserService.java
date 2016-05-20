package com.pb.service.user;

import org.springframework.stereotype.Service;

import com.pb.service.TableUseAbs;
import com.pb.xml.TName;

@Service("UserSer")
public class UserService extends TableUseAbs {

	@Override
	public String getTable() {
		return TName.pUsers;
	}

	@Override
	public String getPrimaryKey() {
		return "user_id";
	}

}
