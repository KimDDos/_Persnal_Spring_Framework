package com.springproject.www.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@Inject
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
	public ResponseEntity<String> isEmail(@PathVariable("email") String email){
		log.info(">>>>> email >>>>>{}", email);
		MemberVO mvo = new MemberVO();
		mvo = msv.isEmail(email);
		return mvo != null ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>("0", HttpStatus.OK); 
	}
	
	@GetMapping("/login")
	public void loginPost() {}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes re) {
		// 로그인 실패시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		// 다시 로그인 유도
		re.addFlashAttribute("email", request.getAttribute("email"));
		re.addFlashAttribute("errMsg", request.getAttribute("errMsg"));
		return "redirect:/member/login";
	}

	public void logout(HttpServletRequest req, HttpServletResponse res) {
		Authentication authentication = SecurityContextHolder.getContext()
				.getAuthentication();
		new SecurityContextLogoutHandler().logout(req, res, authentication);
	}
	
	@GetMapping("/modify")
	public void modify() {}
	
	@PostMapping("/modify")
	public String modify(MemberVO mvo, Model m, HttpServletResponse response, HttpServletRequest request) {
		log.info(">>>>> mvo >>>>> {}", mvo);
		if(mvo.getPwd().isEmpty()) {
			mvo.setPwd(msv.getPwd(mvo.getEmail()));
		} else {
			mvo.setPwd(passwordEncoder.encode(mvo.getPwd()));
		}
		int isOk = msv.modify(mvo);
		m.addAttribute("msg_mod", isOk);
		logout(request, response);
		return "/member/login";
	}
	
	@PostMapping("/delete")
	public String delete(Model m, MemberVO mvo, HttpServletResponse response, HttpServletRequest request) {
		int isOk = msv.delete(mvo.getEmail());
		logout(request, response);
		m.addAttribute("msg_memDel", isOk);
		return "index";
	}
}
