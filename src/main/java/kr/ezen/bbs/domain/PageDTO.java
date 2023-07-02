package kr.ezen.bbs.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int viewPage = 1; // 현재 페이지
	private int blockSize = 5;
	private int blockNum; // 블럭의 위치
	private int blockStart;
	private int blockEnd;
	private int prevPage;
	private int nextPage;
	private int totalPage;
	private int totalCnt;
	private int startRowNum;


	private int startIndex; // 각페이지별 시작값(offset, 0, 10, 20,...)
	private int cntPerPage = 10; // 페이지별 게시글 수

	////////////////////////////
	private String searchType;
	private String keyWord;

	public void setValue(int totalCnt, int cntPerPage) {
		this.totalCnt = totalCnt;
		// 전체 페이지수
		this.totalPage = (int)Math.ceil((double)totalCnt/cntPerPage);
		
		// 페이지별 시작 인덱스 : 0,10,20,....
		this.startIndex = (viewPage-1)*cntPerPage;
		
		// 현재 페이지의 블럭위치 : 0부터 시작
		this.blockNum = (viewPage-1)/blockSize;
		
		// 블럭의 시작값 : 1, 6, 11, 16,....
		this.blockStart = (blockSize*blockNum)+1;
		
		// 블럭의 마지막값
		this.blockEnd = blockStart + (blockSize - 1);
		if(blockEnd > totalPage) blockEnd = totalPage;
		
		// 이전페이지 
		this.prevPage = blockStart - 1;
		// 다음페이지
		this.nextPage = blockEnd + 1;
		
		// nextPage는 전체 페이지수를 초과할 수 없음
		if(nextPage > totalPage) nextPage = totalPage;

		// 행번호 구하기
		// totalCnt(전체 게시글수) : 127, cntPerPage:10, totalPage:13, 내림차순정렬

		// 1페이지 -> 127 ~ 118
		// 2페이지 -> 117 ~ 108
		// 3페이지 -> 107 ~ 98
		// ...

		// startRowNum : 페이지 시작번호
		// 1페이지 시작번호 : totalCnt - 0
		// 2페이지 시작번호 : totalCnt - 10
		// 3페이지 시작번호 : totalCnt - 20

		startRowNum = totalCnt - (viewPage - 1)*cntPerPage;
	}
	
	
}
