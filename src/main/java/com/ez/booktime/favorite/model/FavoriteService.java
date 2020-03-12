package com.ez.booktime.favorite.model;

import java.util.List;

public interface FavoriteService {
	int insertFavorite(FavoriteVO vo);
	int deleteCartOverDate();
	List<FavoriteVO> selectFavorite(FavoriteVO vo);
	int updateQty(FavoriteVO vo);
	int deleteFavorite(String favoriteNoList, String group);
	int moveFavorite(String favoriteNoList);
	FavoriteVO selectOneFavorite(int favoriteNo);
}
