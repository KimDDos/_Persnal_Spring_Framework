package com.springproject.www.service;

import com.springproject.www.security.MemberVO;

public interface MemberService {

	int register(MemberVO mvo);

	MemberVO isEmail(String email);

	boolean updateLastLogin(String authEmail);

	int modify(MemberVO mvo);

	String getPwd(String email);

	int delete(String email);

}
