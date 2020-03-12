package com.ez.booktime.freeBoard.model;

import java.util.List;
import java.util.Map;

import com.ez.booktime.book.controller.BookGradeVO;
import com.ez.booktime.common.SearchVO;

public interface FreeBoardService {
	int insertBoard(FreeBoardVO boardVo);
	List<FreeBoardVO> selectFreeBoardAll(SearchVO searchVo);
	public int selectTotalRecord(SearchVO searchVo);
	FreeBoardVO selectByNo(int boardNo);
	FreeBoardVO selectById(String userid);
	int updateBoard(FreeBoardVO freeBoardVo);
	int drawBoard(int boardNo);
	
	List<FreeBoardVO> selectFreeBoard();
	int countReview(Map<String, Object> map);

	List<FreeBoardVO> selectBoardByCate(String category);
	int writeReview(FreeBoardVO bVo, BookGradeVO gVo);
	List<FreeBoardVO> selectReviews(FreeBoardVO vo);
	int countReviews(FreeBoardVO vo);
	
}
