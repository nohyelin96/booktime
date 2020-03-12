package com.ez.booktime.admin.recommend.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RecommendDAOMybatis implements RecommendDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace="com.mybatis.mapper.recommend.";


	@Override
	public int insertRecommend(RecommendVO recommendVo) {
		return sqlSession.insert(namespace+"insertRecommend",recommendVo);
	}
	
	@Override
	public List<RecommendVO> selectRecommend() {
		return sqlSession.selectList(namespace+"selectRecommend");
	}

	@Override
	public int deleteRecommend(int recombookNo) {
		return sqlSession.delete(namespace+"deleteRecommend",recombookNo);
	}

}
