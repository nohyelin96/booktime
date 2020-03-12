package com.ez.booktime.favorite.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FavoriteDAOMybatis implements FavoriteDAO{
	private String namespace = "com.mybatis.mapper.favorite.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertFavorite(FavoriteVO vo) {
		return sqlSession.insert(namespace+"insertFavorite",vo);
	}

	@Override
	public int selectFavoriteCount(FavoriteVO vo) {
		return sqlSession.selectOne(namespace+"selectFavoriteCount",vo);
	}

	@Override
	public int updateCart(FavoriteVO vo) {
		return sqlSession.update(namespace+"updateCart", vo);
	}

	@Override
	public int deleteCartOverDate(int date) {
		return sqlSession.delete(namespace+"deleteCartOverDate",date);
	}
	@Override
	public int deleteCartOverDateByNonUser(int date) {
		return sqlSession.delete(namespace+"deleteCartOverDateByNonUser",date);
	}

	@Override
	public List<FavoriteVO> selectFavorite(FavoriteVO vo) {
		return sqlSession.selectList(namespace+"selectFavorite",vo);
	}

	@Override
	public int updateQty(FavoriteVO vo) {
		return sqlSession.update(namespace+"updateQty", vo);
	}

	@Override
	public int deleteFavorite(FavoriteVO vo) {
		return sqlSession.delete(namespace+"deleteFavorite", vo);
	}

	@Override
	public FavoriteVO selectOneFavorite(int favoriteNo) {
		return sqlSession.selectOne(namespace+"selectOneFavorite", favoriteNo);
	}

	@Override
	public int paymentOkDeleteCart(Map<String, Object> map) {
		return sqlSession.delete(namespace+"paymentOkDeleteCart", map);
	}

	
}
