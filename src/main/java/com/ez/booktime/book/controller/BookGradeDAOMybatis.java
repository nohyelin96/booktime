package com.ez.booktime.book.controller;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookGradeDAOMybatis implements BookGradeDAO{
	private String namespace = "com.mybatis.mapper.bookGrade.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertBookGrade(BookGradeVO vo) {
		return sqlSession.insert(namespace+"insertBookGrade", vo);
	}

	@Override
	public float gradeByIsbn(BookGradeVO vo) {
		return sqlSession.selectOne(namespace+"gradeByIsbn", vo);
	}
	
}
