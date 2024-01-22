package com.springproject.www.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.springproject.www.domain.CommentVO;
import com.springproject.www.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comment/*")
@RestController
@RequiredArgsConstructor
public class CommentController {
	
	private final CommentService csv;
	
	@PostMapping(value = "/register", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> commentRegist(@RequestBody CommentVO cvo){
		log.info(">>>>> cvo >>>>> {}", cvo);
		int isOk = csv.cmtPost(cvo);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/list/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommentVO>> getList(@PathVariable("bno") long bno){
		List<CommentVO> clist = csv.getList(bno);
		return new ResponseEntity<List<CommentVO>>(clist, HttpStatus.OK);
	}
	
	@GetMapping(value = "/detail/{cno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CommentVO> cmtDetail(@PathVariable("cno") int cno){
		CommentVO cvo = csv.getDetail(cno);
		return  new ResponseEntity<CommentVO>(cvo, HttpStatus.OK); 
	}
	
	@GetMapping(value = "/delete/{cno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("cno") int cno){
		int isOk = csv.delete(cno);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) 
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/modify", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CommentVO cvo){
		int isOk = csv.update(cvo);
		log.info(">>>>> modify cvo >>>>> {}",cvo);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
