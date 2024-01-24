package com.springproject.www.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springproject.www.domain.BoardDTO;
import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.FileVO;
import com.springproject.www.domain.PagingVO;
import com.springproject.www.handler.FileHandler;
import com.springproject.www.handler.PagingHandler;
import com.springproject.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

	private final BoardService bsv;
	
	private final FileHandler fh;

	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO bvo, Model m, @RequestParam(name="files", required = false) MultipartFile[] files) {
		List<FileVO> flist = null;
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isOk = bsv.insert(new BoardDTO(bvo, flist));
		m.addAttribute("msg_reg", isOk);
		return "redirect:/board/list";
	}
	
	@GetMapping("/list")
	public void boardList(Model m, PagingVO pgvo) {
		List <BoardVO> list = bsv.getList(pgvo);
		log.info(">>>> list >>>> {}", list);
		int totalCount = bsv.getTotalCount();

		m.addAttribute("ph", new PagingHandler(pgvo, totalCount));
		m.addAttribute("list", list);
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(@RequestParam("bno") int bno, Model m) {
		m.addAttribute("bdto", bsv.getDetail(bno));
	}
		
	@PostMapping("modify")
	public String modify(BoardVO bvo, RedirectAttributes re) {
		log.info(">>>> bvo >>>> {}", bvo);
		int isOk = bsv.modify(bvo);
		re.addAttribute("bno", bvo.getBno());
		re.addFlashAttribute("msg_mod", isOk);
		return "redirect:/board/detail";
	}
	
	@GetMapping("delete")
	public String delete(@RequestParam("bno") int bno, Model m) {
		int isOk = bsv.delete(bno);
		m.addAttribute("msg_del", isOk);
		return "redirect:/board/list";
	}
	
	@Async
	@GetMapping("/commendUp/{bno}")
	@ResponseBody
	public String commendUp(@PathVariable("bno") long bno) {
		int isOk = bsv.commendUp(bno);
		String result = Integer.toString(bsv.getCommend(bno));
		return isOk > 0 ? result : "0";
	}
	
	@Async
	@GetMapping("/commendDown/{bno}")
	@ResponseBody
	public String commendDown(@PathVariable("bno") long bno) {
		int isOk = bsv.commendDown(bno);
		String result = Integer.toString(bsv.getNotCommend(bno));
		return isOk > 0 ? result : "0";
	}
	
	@DeleteMapping(value = "/fileDelete/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> fileDelete(@PathVariable("uuid") String uuid){
		int isOk = bsv.fileDelete(uuid);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
