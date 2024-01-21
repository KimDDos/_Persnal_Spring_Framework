package com.springproject.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.springproject.www.domain.CommentVO;
import com.springproject.www.repository.BoardDAO;
import com.springproject.www.repository.CommentDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService{

	private final CommentDAO cdao;
	
	@Override
	public int cmtPost(CommentVO cvo) {
		return cdao.insert(cvo);
	}

	@Override
	public List<CommentVO> getList(long bno) {
		// TODO Auto-generated method stub
		return cdao.getList(bno);
	}
	
	@Override
	public CommentVO getDetail(int cno) {
		return cdao.detail(cno);
	}
	
	@Override
	public int delete(int cno) {
		return cdao.delete(cno);
	}
	
	@Override
	public int update(CommentVO cvo) {
		return cdao.modify(cvo);
	}
	
}
