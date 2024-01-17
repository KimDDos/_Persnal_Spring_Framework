package com.springproject.www.service;

import java.util.List;

import com.springproject.www.domain.BoardVO;

public interface BoardService {

	int insert(BoardVO bvo);

	List<BoardVO> getList();

	BoardVO getDetail(int bno);

}
