package com.springproject.www.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springproject.www.security.MemberVO;
import com.springproject.www.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/*")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService msv;
	
	private BCryptPasswordEncoder passwordEncoder;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping
	public String register(MemberVO mvo, Model m) {
		log.info(">>>> mvo >>>> {}", mvo);
		// 아이디 중복 확인? 이건 화면에서 구현합시다.
		mvo.setPwd(passwordEncoder.encode(mvo.getPwd()));
		int isOk = msv.register(mvo);
		m.addAttribute("msg_MemReg", isOk);
		return "index";
	}
	
	@GetMapping("/isEmail/{email}")
	@ResponseBody
	public ResponseEntity<String> isEmail(@PathVariable("email") String email){
		log.info(">>>>> email >>>>>{}", email);
		MemberVO mvo = new MemberVO();
		mvo = msv.isEmail(email);
		return mvo != null ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>("0", HttpStatus.OK); 
	}
}
