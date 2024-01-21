package com.springproject.www.service;

import java.util.List;

import com.springproject.www.domain.CommentVO;

public interface CommentService {

	int cmtPost(CommentVO cvo);

	List<CommentVO> getList(long bno);

	CommentVO getDetail(int cno);

	int delete(int cno);

	int update(CommentVO cvo);

}
