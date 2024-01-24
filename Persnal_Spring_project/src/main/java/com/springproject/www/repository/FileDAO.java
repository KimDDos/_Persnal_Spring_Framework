package com.springproject.www.repository;

import java.util.List;

import com.springproject.www.domain.FileVO;

public interface FileDAO {

	void insert(FileVO fvo);

	List<FileVO> getFlist(int bno);

	int fileDelete(String uuid);

}
