package kr.ezen.service;

import java.util.List;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.PageDTO;

public interface BoardService {
	// 게시글 등록
	//게시글을 저장 용도로만 사용하여 값을 불러오지 않아도됨 void
	void register(BoardDTO dto);
	
	// 게시판 리스트
//	List<BoardDTO> getList();
	List<BoardDTO> getList(PageDTO pDto);
	
	// 글상세보기
//	BoardDTO view(int bid);
	BoardDTO view(int bid, String mode);
	
	// 글수정
	int modify(BoardDTO dto);
	
	// 글삭제
	int remove(int bid);
	
	// 조회수 증가
//	void hitAdd(int bid);
	
	// 전체 게시글 수
	int totalCnt(PageDTO pDto);
}
