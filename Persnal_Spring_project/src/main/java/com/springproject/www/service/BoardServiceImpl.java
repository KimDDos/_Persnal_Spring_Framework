package com.springproject.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.repository.BoardDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDAO bdao;

	@Override
	public int insert(BoardVO bvo) {
		return bdao.insert(bvo);
	}

	@Override
	public List<BoardVO> getList() {
		return bdao.getList();
	}

	@Override
	public BoardVO getDetail(int bno) {
		return bdao.detail(bno);
	}
	
}
