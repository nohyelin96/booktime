package com.ez.booktime.favorite.model;

import java.util.List;
import java.util.Map;

public interface FavoriteDAO {
	int insertFavorite(FavoriteVO vo);
	int selectFavoriteCount(FavoriteVO vo);
	int updateCart(FavoriteVO vo);
	int deleteCartOverDate(int date);
	int deleteCartOverDateByNonUser(int date);
	List<FavoriteVO> selectFavorite(FavoriteVO vo);
	int updateQty(FavoriteVO vo);
	int deleteFavorite(FavoriteVO vo);
	FavoriteVO selectOneFavorite(int favoriteNo);
	int paymentOkDeleteCart(Map<String, Object> map);
}
