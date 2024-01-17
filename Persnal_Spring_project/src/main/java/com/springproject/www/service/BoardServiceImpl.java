package com.springproject.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.PagingVO;
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
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.getList(pgvo);
	}

	@Override
	public BoardVO getDetail(int bno) {
		bdao.upCount(bno);
		return bdao.detail(bno);
	}

	@Override
	public int modify(BoardVO bvo) {
		return bdao.modify(bvo);
	}

	@Override
	public void upReadCount(int bno) {
		bdao.upCount(bno);
	}

	@Override
	public int delete(int bno) {
		return bdao.deleteBoard(bno);
	}

	@Override
	public int getTotalCount() {
		return bdao.getTotal();
	}
	
}
