package com.ez.booktime.freeBoard.model;

import java.util.List;
import java.util.Map;

import com.ez.booktime.common.SearchVO;

public interface FreeBoardDAO {
	int insertBoard(FreeBoardVO boardVo);
	List<FreeBoardVO> selectFreeBoardAll(SearchVO searchVo);
	public int selectTotalRecord(SearchVO searchVo);
	FreeBoardVO selectByNo(int boardNo);
	FreeBoardVO selectById(String userid);
	int updateBoard(FreeBoardVO freeBoardVo);
	int drawBoard(int boardNo);
	
	List<FreeBoardVO> selectFreeBoard();
	List<FreeBoardVO> selectBoardByCate(String category);

	int countReview(Map<String, Object> map);	//자신이 작성한 리뷰
	List<FreeBoardVO> selectReviews(FreeBoardVO vo);
	int countReviews(FreeBoardVO vo); // 디테일 페이지에서 해당 책의 리뷰 토탈
}
