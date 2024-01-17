package com.springproject.www.repository;

import java.util.List;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO detail(int bno);

	int modify(BoardVO bvo);

	void upCount(int bno);

	int deleteBoard(int bno);

	int getTotal();

}
