package com.springproject.www.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

	private final BoardService bsv;

	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO bvo, Model m) {
		log.info(">>>> bvo >>>>", bvo);
		int isOk = bsv.insert(bvo);
		m.addAttribute("msg_reg", isOk);
		return "/board/list";
	}
	
	@GetMapping("/list")
	public void boardList(Model m) {
		List <BoardVO> list = bsv.getList();
		log.info(">>>> list >>>> {}", list);
		m.addAttribute("list", list);
	}
	
	@GetMapping("/detail")
	public void detail(@RequestParam("bno") int bno, Model m) {
		log.info(">>>>> detail bno >>>>>",bno);
		BoardVO bvo = bsv.getDetail(bno);
		log.info(">>>>> bvo >>>>>",bvo);
		m.addAttribute("bvo", bvo);
	}
	
}
