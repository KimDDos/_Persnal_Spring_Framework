package com.springproject.www.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.springproject.www.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comment/*")
@RestController
@RequiredArgsConstructor
public class CommentController {
	
	private final CommentService csv;
	
}
