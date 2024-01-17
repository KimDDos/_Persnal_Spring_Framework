package com.springproject.www;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.repository.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.springproject.www.config.RootConfig.class})
public class BoardTest {

	@Inject
	private BoardDAO bdao;
	
	@Test
	public void InsertBoard() {
		for(int i=0; i<400; i++) {
			BoardVO bvo = new BoardVO();
			bvo.setTitle("Test " + i);
			bvo.setWriter("Total_Admin");
			bvo.setContent("Testing " + i);
			bdao.insert(bvo);
		}
	}
	
}
