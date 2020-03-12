package com.ez.booktime.category.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookCategoryDAOMybatis implements BookCategoryDAO{
	private String namespace = "com.mybatis.mapper.category.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<BookCategoryVO> selectAllCategory() {
		return sqlSession.selectList(namespace+"selectAllCategory");
	}

	@Override
	public BookCategoryVO selectCategoryInfoByName(String categoryName) {
		return sqlSession.selectOne(namespace+"selectCategoryInfoByName", categoryName);
	}

	@Override
	public List<BookCategoryVO> selectCatgoryBar() {
		return sqlSession.selectList(namespace+"selectAllCategory");
	}
	
}
