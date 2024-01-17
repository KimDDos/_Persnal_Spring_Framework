package com.springproject.www.repository;

import java.util.List;

import com.springproject.www.domain.BoardVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList();

	BoardVO detail(int bno);

}
