package com.springproject.www.service;

import org.springframework.stereotype.Service;

import com.springproject.www.repository.MemberDAO;
import com.springproject.www.security.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberDAO mdao;

	@Override
	public int register(MemberVO mvo) {
		return mdao.insert(mvo);
	}

	@Override
	public MemberVO isEmail(String email) {
		// TODO Auto-generated method stub
		return mdao.isEmail(email);
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}
	
}
