package com.springproject.www.service;

import java.util.List;

import com.springproject.www.domain.BoardDTO;
import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.PagingVO;

public interface BoardService {

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo);
	
	void upReadCount(int bno);

	int delete(int bno);

	int getTotalCount();

	int commendUp(long bno);

	int commendDown(long bno);

	int getCommend(long bno);

	int getNotCommend(long bno);

	int insert(BoardDTO bdto);

}
