package com.ez.booktime.freeBoard.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ez.booktime.book.controller.BookGradeDAO;
import com.ez.booktime.book.controller.BookGradeService;
import com.ez.booktime.book.controller.BookGradeVO;
import com.ez.booktime.common.SearchVO;

@Service
public class FreeBoardServiceImpl implements FreeBoardService{

	@Autowired
	private FreeBoardDAO boardDao;
	
	@Autowired
	private BookGradeDAO gradeDao;
	
	@Override
	public int insertBoard(FreeBoardVO boardVo) {
		return boardDao.insertBoard(boardVo);
	}

	@Override
	public List<FreeBoardVO> selectFreeBoardAll(SearchVO searchVo) {
		return boardDao.selectFreeBoardAll(searchVo);
	}

	@Override
	public FreeBoardVO selectByNo(int boardNo) {
		return boardDao.selectByNo(boardNo);
	}

	@Override
	public FreeBoardVO selectById(String userid) {
		return boardDao.selectById(userid);
	}

	@Override
	public int updateBoard(FreeBoardVO freeBoardVo) {
		return boardDao.updateBoard(freeBoardVo);
	}

	@Override
	public int drawBoard(int boardNo) {
		return boardDao.drawBoard(boardNo);
	}

	@Override
	public int selectTotalRecord(SearchVO searchVo) {
		return boardDao.selectTotalRecord(searchVo);
	}

	@Override
	public List<FreeBoardVO> selectFreeBoard() {
		return boardDao.selectFreeBoard();
	}

	@Override
	public int countReview(Map<String, Object> map) {
		return boardDao.countReview(map);
	}

	@Override
	public List<FreeBoardVO> selectBoardByCate(String category) {
		return boardDao.selectBoardByCate(category);
	}
	
	@Override
	@Transactional
	public int writeReview(FreeBoardVO bVo, BookGradeVO gVo) {
		int cnt = 0;
		
		try{
			cnt = boardDao.insertBoard(bVo);
			if(cnt>0) {
				gVo.setBoardNo(bVo.getBoardNo());
				
				cnt = gradeDao.insertBookGrade(gVo);
			}
		}catch (RuntimeException e) {
			e.printStackTrace();
			cnt = -1;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return cnt;
	}

	@Override
	public int countReviews(FreeBoardVO vo) {
		return boardDao.countReviews(vo);
	}

	@Override
	public List<FreeBoardVO> selectReviews(FreeBoardVO vo) {
		return boardDao.selectReviews(vo);
	}

}
