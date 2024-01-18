package com.springproject.www.repository;

import java.util.List;

import com.springproject.www.security.AuthVO;
import com.springproject.www.security.MemberVO;

public interface MemberDAO {

	List<AuthVO> selectAuths(String username);

	int insert(MemberVO mvo);

	MemberVO isEmail(String email);

	int updateLastLogin(String authEmail);

}
