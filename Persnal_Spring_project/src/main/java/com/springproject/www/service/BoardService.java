package com.springproject.www.service;

import java.util.List;

import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.PagingVO;

public interface BoardService {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo);
	
	void upReadCount(int bno);

	int delete(int bno);

	int getTotalCount();

}
