package kr.ezen.bbs.mapper;

import java.util.List;

import kr.ezen.bbs.domain.MemberDTO;
import org.apache.ibatis.annotations.Mapper;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.PageDTO;

//@Mapper
public interface BoardMapper {
	// 게시글 등록
	void insert(BoardDTO dto);
	
	// 게시판 리스트
//	List<BoardDTO> getList();
	List<BoardDTO> getList(PageDTO pDto);
	
	// 글상세보기
	BoardDTO view(int bid);
	
	// 게시글 수정
	int update(BoardDTO dto);
	
	// 게시글 삭제
	int delete(int bid);
	
	// 조회수 증가
	void hitAdd(int bid);
	
	// 전체 게시글 수
	int totalCnt(PageDTO pDto);


}
