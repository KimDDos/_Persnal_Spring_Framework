package com.springproject.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.springproject.www.domain.BoardDTO;
import com.springproject.www.domain.BoardVO;
import com.springproject.www.domain.FileVO;
import com.springproject.www.domain.PagingVO;
import com.springproject.www.repository.BoardDAO;
import com.springproject.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

	private final BoardDAO bdao;
	
	private final FileDAO fdao;

	@Override
	public int insert(BoardDTO bdto) {
		
		int isOk = bdao.insert(bdto.getBvo());
		if(bdto.getFlist() == null) {
			return isOk;
		}
		
		// bvo insert 후 파일도 있다면
		if(isOk > 0 && bdto.getFlist().size() > 0) {
			// bno setting
			long bno = bdao.selectOneBno();
			// 가장 마지막에 등록된 bno
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				fdao.insert(fvo);
			}
		}
		return isOk;
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

	@Override
	public int commendUp(long bno) {
		return bdao.commendUp(bno);
	}

	@Override
	public int commendDown(long bno) {
		return bdao.commendDown(bno);
	}

	@Override
	public int getCommend(long bno) {
		return bdao.getCommend(bno);
	}

	@Override
	public int getNotCommend(long bno) {
		return bdao.getNotCommend(bno);
	}
	
}
