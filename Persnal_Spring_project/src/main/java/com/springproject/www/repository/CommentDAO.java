package com.springproject.www.repository;

import java.util.List;

import com.springproject.www.domain.CommentVO;

public interface CommentDAO {

	int insert(CommentVO cvo);

	List<CommentVO> getList(long bno);

	CommentVO detail(int cno);

	int delete(int cno);

	int modify(CommentVO cvo);

}
