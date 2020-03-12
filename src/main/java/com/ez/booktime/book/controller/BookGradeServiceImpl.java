package com.ez.booktime.book.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookGradeServiceImpl implements BookGradeService{
	@Autowired
	private BookGradeDAO gradeDao;
	
	@Override
	public float gradeByIsbn(BookGradeVO vo) {
		return gradeDao.gradeByIsbn(vo);
		//isbn과 userid를 필요로하는 sql
		//isbn만 있으면 평균값
		//userid도 있으면 그 유저가 매긴 평점의 값
		//소수점 첫째짜리까지
	}

}
