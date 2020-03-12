package com.ez.booktime.common.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDAOMybatis implements CommonDAO{
	private String namespace = "com.mybatis.mapper.common.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Map<String, Object> countInfo() {
		return sqlSession.selectOne(namespace+"countInfo");
	}
	
}
